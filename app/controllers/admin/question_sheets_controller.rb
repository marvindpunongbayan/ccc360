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

    def sort_question_sheets
      @active_question_sheets.sort!{ |qs1, qs2| 
        s1 = qs1.question_sheet_pr_info.form_type <=> qs2.question_sheet_pr_info.form_type
        s2 = qs1.label <=> qs2.label
        s1 != 0 ? s1 : s2
      }
    end

end
