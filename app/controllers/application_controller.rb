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
        raise "no user" unless current_user
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

end
