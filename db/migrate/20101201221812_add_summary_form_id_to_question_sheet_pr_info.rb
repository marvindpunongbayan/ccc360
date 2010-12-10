class AddSummaryFormIdToQuestionSheetPrInfo < ActiveRecord::Migration
  def self.up
    add_column :pr_question_sheet_pr_infos, :summary_form_id, :integer
  end

  def self.down
    remove_column :pr_question_sheet_pr_infos, :summary_form_id
  end
end
