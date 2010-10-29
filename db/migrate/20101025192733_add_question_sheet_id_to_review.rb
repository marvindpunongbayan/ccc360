class AddQuestionSheetIdToReview < ActiveRecord::Migration
  def self.up
    add_column :pr_reviews, :question_sheet_id, :integer
  end

  def self.down
    remove_column :pr_reviews, :question_sheet_id
  end
end
