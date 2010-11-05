class AddAccessKeyToReviewers < ActiveRecord::Migration
  def self.up
    add_column :pr_reviewers, :access_key, :string
  end

  def self.down
    remove_column :pr_reviewers, :access_key
  end
end
