class Review < ActiveRecord::Base
  belongs_to :subject, :class_name => "Person"
  belongs_to :initiator, :class_name => "Person"
  belongs_to :question_sheet
  has_many :reviewer_wrappers, :class_name => "Reviewer"
  has_many :reviewers, :through => :reviewer_wrappers, :class_name => "Person", :source => :person
  set_table_name "pr_reviews"

  def name
    self[:name].present? ? self[:name] : question_sheet.label
  end

  def past?
    # TODO
    false
  end

  def question_sheets
    [ question_sheet ]
  end
  
  def late?
    Date.today > due && !complete
  end

  def complete
    false
  end
end
