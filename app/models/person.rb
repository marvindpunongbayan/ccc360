require_dependency "#{Rails.root}/vendor/plugins/common_engine/app/models/person.rb"

class Person < ActiveRecord::Base
  has_many :initiated_reviews, :class_name => "Review", :foreign_key => "initiator_id"
  has_many :subjected_reviews, :class_name => "Review", :foreign_key => "subject_id", :order => "created_at DESC"
  has_many :reviewings, :class_name => "Reviewer", :foreign_key => "person_id"
  has_many :participating_reviews, :class_name => "Review", :through => :reviewings, :source => :review
  has_one :admin
  has_many :personal_forms
  has_many :reminders, :order => "COALESCE(reminder_date, 'ZZZ') ASC" # nulls go at the end
  has_one :person_access

  def get_person_access
    @person_access ||= PersonAccess.find_or_create_by_person_id(self.id)
  end

  def admin?
    admin.present?
  end

  def pr_human_gender
    if is_male? then "male" elsif is_female? then "female" else "genderless" end
  end
end
