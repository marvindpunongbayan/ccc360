class AddSummaryFormFlagToQuestionSheetPrInfo < ActiveRecord::Migration
  def self.up
    add_column :pr_question_sheet_pr_infos, :summary, :boolean, :default => false
  end

  def self.down
    remove_column :pr_question_sheet_pr_infos, :summary
  end
end
