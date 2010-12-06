class Reminder < ActiveRecord::Base
  set_table_name "pr_reminders"
  validates_presence_of :label, :reminder_date
  belongs_to :person
end
