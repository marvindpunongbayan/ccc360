class Reviewer < ActiveRecord::Base
  set_table_name "pr_reviewers"
  belongs_to :review
  belongs_to :person
end
