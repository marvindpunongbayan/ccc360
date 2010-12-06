class Reminder < ActiveRecord::Base
  validates_presence_of :label, :reminder_date
  belongs_to :person
end
