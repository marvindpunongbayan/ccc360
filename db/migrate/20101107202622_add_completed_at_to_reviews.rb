class AddCompletedAtToReviews < ActiveRecord::Migration
  def self.up
    add_column :pr_reviews, :completed_at, :datetime
  end

  def self.down
    remove_column :pr_reviews, :completed_at
  end
end
