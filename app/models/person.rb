#require_dependency "#{Rails.root}/vendor/plugins/common_engine/app/models/person.rb"

class Person < ActiveRecord::Base
  self.table_name = "ministry_person"
  self.primary_key = "personID"
  
  has_many :initiated_reviews, :class_name => "Review", :foreign_key => "initiator_id"
  has_many :subjected_reviews, :class_name => "Review", :foreign_key => "subject_id", :order => "created_at DESC"
  has_many :reviewings, :class_name => "Reviewer", :foreign_key => "person_id"
  has_many :participating_reviews, :class_name => "Review", :through => :reviewings, :source => :review
  has_one :admin
  has_many :personal_forms
  has_many :reminders, :order => "COALESCE(reminder_date, 'ZZZ') ASC" # nulls go at the end
  has_one :person_access
  has_many :team_members, :foreign_key => "personID"
  has_many :teams, :through => :team_members

  def get_person_access
    @person_access ||= PersonAccess.find_or_create_by_person_id(self.id)
  end

  def admin?
    admin.present?
  end

  def pr_human_gender
    if is_male? then "male" elsif is_female? then "female" else "genderless" end
  end

  def <=>(other)
    lnd = self.lastName <=> other.lastName
    return lnd unless lnd == 0
    return self.firstName <=> other.firstName
  end

  def all_team_members(remove_self = false)
    my_local_level_ids = teams.collect &:id
    mmtm = TeamMember.where(:teamID => my_local_level_ids).joins(:person).order("lastName, firstName ASC")
    people = mmtm.collect(&:person).flatten.uniq
    people.delete(self) if remove_self
    return people
  end

  def account_balance
    0
  end

  # "first_name last_name"
  def full_name
    first_name.to_s  + " " + last_name.to_s
  end
  
  # "nickname last_name"
  def informal_full_name
    nickname.to_s  + " " + last_name.to_s
  end

  # an alias for firstName using standard ruby/rails conventions
  def first_name
    firstName
  end
                
  def first_name=(f)    
    write_attribute("firstName", f)
  end

  # an alias for lastName using standard ruby/rails conventions
  def last_name
    lastName
  end
                
  def last_name=(l)   
    write_attribute("lastName", l)
  end
end