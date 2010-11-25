class QuestionSheetPrInfo < ActiveRecord::Base
  set_table_name "pr_question_sheet_pr_infos"

  belongs_to :question_sheet

  def questionnaire_type
    if personal
      return "Personal Form"
    elsif summary
      return "Summary Form"
    else
      "Review Form"
    end
  end
end
