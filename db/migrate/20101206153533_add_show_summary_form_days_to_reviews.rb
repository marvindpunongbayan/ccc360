class AddShowSummaryFormDaysToReviews < ActiveRecord::Migration
  def self.up
    add_column :pr_reviews, :show_summary_form_days, :integer, :default => 14
  end

  def self.down
    remove_column :pr_reviews, :show_summary_form_days
  end
end
