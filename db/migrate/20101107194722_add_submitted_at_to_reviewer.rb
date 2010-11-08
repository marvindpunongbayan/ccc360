class AddSubmittedAtToReviewer < ActiveRecord::Migration
  def self.up
    add_column :pr_reviewers, :submitted_at, :datetime
  end

  def self.down
    remove_column :pr_reviewers, :submitted_at
  end
end
