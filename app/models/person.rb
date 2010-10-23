require_dependency "vendor/plugins/common_engine/app/models/person.rb"

class Person < ActiveRecord::Base
  has_many :initiated_reviews, :class_name => "Review", :foreign_key => "initiator_id"
  has_many :subjected_reviews, :class_name => "Review", :foreign_key => "subject_id"
  has_many :reviewings, :class_name => "Reviewer", :foreign_key => "person_id"
  has_many :participating_reviews, :class_name => "Review", :through => :reviewings, :source => :person
end
