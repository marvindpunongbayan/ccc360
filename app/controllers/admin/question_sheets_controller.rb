require_dependency "#{Rails.root}/vendor/plugins/questionnaire_engine/app/controllers/admin/question_sheets_controller.rb"

class Admin::QuestionSheetsController < ApplicationController
  before_filter :set_qe_flags

  def toggle_personal
    get_question_sheet
    @question_sheet.personal = !@question_sheet.personal
    @question_sheet.save!
  end

  protected

    def set_qe_flags
      @questionnaire = true
      @qe_admin = true
    end
end
