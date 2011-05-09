require 'authenticated_system'
require 'authentication_filter'

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  before_filter :check_valid_user
  #before_filter :set_time_zone

  protect_from_forgery

  def self.application_name
    'pr'
  end

  def application_name
    ApplicationController.application_name
  end
  
  def set_time_zone
    offset = Time.now.dst? ? 3600 : 0
    Time.zone = (request.env['rack.timezone.utc_offset'].present? ? request.env['rack.timezone.utc_offset'] : -14400) - offset
  end

  def search
    @limit ||= 10
    if params[:name].present?
      term = '%' + params[:name] + '%'
      conditions = ["firstName like ? OR lastName like ? OR preferredName like ? OR concat(firstName, ' ', lastName) like ? OR concat(preferredName, ' ', lastname) like ?", term, term, term, params[:name] + '%', params[:name] + '%']
      if @search_people_filter
        conditions[0] = "(#{conditions[0]}) AND (personID in (0, ?))"
        conditions << @search_people_filter
      end
      order = "firstName ASC, lastName ASC"
      @people = Person.where(conditions).limit(@limit).order(order)
      @total = Person.where(conditions).count
    else
      render :nothing => true
    end
  end

  protected

    def set_layout
      if params["view"] == "print"
        "print"
      else
        "application"
      end
    end

    def check_valid_user
      if session[:person_id].present?
        return nil
      elsif CASClient::Frameworks::Rails::Filter.filter(self) && AuthenticationFilter.filter(self)
        unless pr_user# && pr_user.can_edit_questionnaire?
          redirect_to '/'
          return false
        end
      else
        return false
      end
    end

    def current_user
      unless @current_user
        if session[:user_id]
          @current_user = User.find_by_id(session[:user_id])
          # developer method to override user in session for testing
          if params[:user_id] && params[:su] && (@current_user.developer? || (session[:old_user_id] && old_user = User.find(session[:old_user_id]).developer?))
            session[:old_user_id] = @current_user.id if @current_user.developer?
            session[:user_id] = params[:user_id]
            @current_user = User.find_by_id(session[:user_id])
          end
        end
        if session[:casfilterreceipt]
          @current_user ||= User.find_by_globallyUniqueID(session[:casfilterreceipt].attributes[:ssoGuid])
        end
      end
      @current_user
    end
    helper_method :current_user

    def current_person
      unless @current_person
        if current_user
          # Get their user, or create a new one if theirs doesn't exist
          @current_person = current_user.person || current_user.create_person_and_address
        elsif session[:person_id].present?
          @current_person = Person.find session[:person_id]
        else
          return nil
        end
      end
      @current_person
    end
    helper_method :current_person

    # set up access control
    def pr_user
      return nil unless current_user
      @pr_user ||= PrUser.find_by_ssm_id(current_user.id)
      unless @pr_user
        @pr_user = PrUser.create! :ssm_id => current_user.id
      end
      unless session[:login_stamped] || @pr_user.nil?
        @pr_user.update_attribute(:last_login, Time.now)
        session[:login_stamped] = true
      end
      @pr_user
    end
    helper_method :pr_user

    def set_personal_question_sheets
      @question_sheets = QuestionSheet.find_all_by_archived(false, :joins => :question_sheet_pr_info,
           :conditions => [ "form_type = 'personal'" ])
    end

    def set_review_question_sheets
      @review_question_sheets = QuestionSheet.find_all_by_archived(false, :joins => :question_sheet_pr_info,
           :conditions => [ "form_type is null or form_type = 'review'" ])
    end


    # basic persmissions

    def base_url
      if request.port != 80
        $base_url = request.protocol + request.host_with_port
      else
        $base_url = request.protocol + request.host
      end
    end

    def admin?
      current_person && current_person.admin?
    end
    helper_method :admin?

    def team_leader?
      admin? || (current_person && current_person.team_members.find_by_is_leader(true).present?)
    end
    helper_method :team_leader?

    def can_see_people?
      team_leader? || admin?
    end
    helper_method :can_see_people?

    def is_leading_person?(p)
      return true if admin?
      return false unless can_see_people?
      leading_team_ids = current_person.team_members.find_all_by_is_leader(true).collect &:teamID
      person_member = p.team_members.collect &:teamID
      (leading_team_ids & person_member).length > 0
    end
    helper_method :is_leading_person?

    def can_see_person?(p)
      return true if p == current_person
      return is_leading_person?(p)
    end
    helper_method :can_see_person?

    def can_view_summary?(person, summary)
      is_leading_person?(person) || person == current_person || summary.review.initiator = person
    end
    helper_method :can_view_summary?

    def no_permission
      render :text => "no permission"
    end

    def error_and_try_back(s)
      flash[:error] = s
      if request.env["HTTP_REFERER"]
        redirect_to :back
      else
        render :text => "", :layout => true
      end
    end
end
