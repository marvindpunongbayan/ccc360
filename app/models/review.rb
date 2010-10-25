class Review < ActiveRecord::Base
  belongs_to :subject, :class_name => "Person"
  belongs_to :initiator, :class_name => "Person"
  has_many :reviewer_wrappers, :class_name => "Reviewer"
  has_many :reviewers, :through => :reviewer_wrappers, :class_name => "Person", :source => :person
  set_table_name "pr_reviews"

  def past?
    # TODO
    false
  end
end
