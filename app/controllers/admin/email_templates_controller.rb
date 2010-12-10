require_dependency "#{Rails.root}/vendor/plugins/questionnaire_engine/app/controllers/admin/email_templates_controller.rb"

class Admin::EmailTemplates < ApplicationController
  before_filter :ensure_permission

  protected

    def ensure_permission
      if current_user.developer?
        error_and_try_back("Sorry, you don't have permission to access this page.")
      end
    end

end
