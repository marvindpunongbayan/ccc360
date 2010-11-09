require 'authenticated_system'
require 'authentication_filter'

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  before_filter :check_valid_user

  protect_from_forgery

  def self.application_name
    'pr'
  end

  def application_name
    ApplicationController.application_name
  end

  def search
    @limit ||= 10
    if params[:name].present?
      term = '%' + params[:name] + '%'
      conditions = ["firstName like ? OR lastName like ? OR concat(firstname, ' ', lastname) like ?", term, term, params[:name] + '%']
      if @search_people_filter
        conditions[0] = "(#{conditions[0]}) AND (personID in (0, ?))"
        conditions << @search_people_filter
      end
      @people = Person.where(conditions).includes(:user).limit(@limit)
      @total = Person.where(conditions).count
    else
      render :nothing => true
    end
  end

  protected

    def check_valid_user
      if CASClient::Frameworks::Rails::Filter.filter(self) && AuthenticationFilter.filter(self)
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
        return nil unless current_user
        # Get their user, or create a new one if theirs doesn't exist
        @current_person = current_user.person || current_user.create_person_and_address
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
                                                            :conditions => [ "personal = true" ])
    end

    def set_review_question_sheets
      @review_question_sheets = QuestionSheet.find_all_by_archived(false, :joins => :question_sheet_pr_info,
                                                            :conditions => [ "personal = false or personal is null" ])
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
      Admin.find_by_person_id(current_person.id).present?
    end
    helper_method :admin?

    def team_leader?
      admin? || current_person.ministry_missional_team_members.find_by_is_leader(true).present?
    end
    helper_method :team_leader?

    def can_see_people?
      team_leader? || admin?
    end
    helper_method :can_see_people?

    def can_see_person?(p)
      return true if p == current_person
      return true if admin?
      return false unless can_see_people?
      leading_team_ids = current_person.ministry_missional_team_members.find_all_by_is_leader(true).collect &:teamID
      person_member = p.ministry_missional_team_members.collect &:teamID
      (leading_team_ids & person_member).length > 0
    end
    helper_method :can_see_person?

    def can_start_new_reviews?
      admin? || current_person.ministry_missional_team_members.present?
    end
    helper_method :can_start_new_reviews?

    def no_permission
      render :text => "no permission"
    end
end
