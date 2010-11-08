require_dependency "#{Rails.root}/vendor/plugins/questionnaire_engine/app/controllers/answer_sheets_controller.rb"
class AnswerSheetsController < ApplicationController
  def submit
    return false unless validate_sheet
    @answer_sheet.submit!
    flash[:notice] = "Your review has been submitted and is now moved to past reviews."
    render :update do |page|
      page.redirect_to dashboard_url
    end
  end
end
