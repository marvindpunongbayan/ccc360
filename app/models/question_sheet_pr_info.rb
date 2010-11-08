class QuestionSheetPrInfo < ActiveRecord::Base
  set_table_name "pr_question_sheet_pr_infos"

  belongs_to :question_sheet
end
