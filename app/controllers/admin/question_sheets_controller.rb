require_dependency "vendor/plugins/questionnaire_engine/app/controllers/admin/question_sheets_controller.rb"

class Admin::QuestionSheetsController < ApplicationController
  def toggle_personal
    get_question_sheet
    @question_sheet.personal = !@question_sheet.personal
    @question_sheet.save!
  end
end
