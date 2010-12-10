class AddEmailSentAtToReminder < ActiveRecord::Migration
  def self.up
    add_column :pr_reminders, :email_sent_at, :datetime
  end

  def self.down
    remove_column :pr_reminders, :email_sent_at
  end
end
