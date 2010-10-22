class Review < ActiveRecord::Base
  belongs_to :subject, :class_name => "Person"
  belongs_to :initiator, :class_name => "Person"
  set_table_name "pr_reviews"
end
