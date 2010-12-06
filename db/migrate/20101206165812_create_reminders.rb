class CreateReminders < ActiveRecord::Migration
  def self.up
    create_table :reminders do |t|
      t.integer :person_id
      t.string :label
      t.string :note
      t.date :reminder_date
      t.boolean :send_email, :default => false
      t.integer :email_days_diff, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :reminders
  end
end
