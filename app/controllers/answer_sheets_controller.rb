require_dependency "#{Rails.root}/vendor/plugins/questionnaire_engine/app/controllers/answer_sheets_controller.rb"
class AnswerSheetsController < ApplicationController
  layout :set_layout

  def submit
    return false unless validate_sheet
    @answer_sheet.submit!
    case params[:answer_sheet_type]
    when "PersonalForm"
      flash[:notice] = "Your answers have been saved."
      render :update do |page|
        page.redirect_to home_url
      end
    when "Reviewer"
      flash[:notice] = "Your review has been submitted and is now moved to 'Submitted review requests'."
      render :update do |page|
        page.redirect_to home_url
      end
    when "SummaryForm"
      render :update do |page|
        page.redirect_to reviews_url
      end
    end
  end
end
