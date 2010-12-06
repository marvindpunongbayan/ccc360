class AddFakeDeletedToReviewsAndPrQuestionSheets < ActiveRecord::Migration
  def self.up
    add_column :pr_reviews, :fake_deleted, :boolean, :default => false
    add_column :pr_question_sheets, :fake_deleted, :boolean, :default => false
  end

  def self.down
    remove_column :pr_reviews, :fake_deleted
    remove_column :pr_question_sheets, :fake_deleted
  end
end
