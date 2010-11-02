class Reviewer < ActiveRecord::Base
  set_table_name "pr_reviewers"
  belongs_to :review
  belongs_to :person

  def question_sheet
    review.question_sheet
  end

  def question_sheets
    [ review.question_sheet ]
  end

end
