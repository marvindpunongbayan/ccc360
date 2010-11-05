class PersonalForm < ActiveRecord::Base
  set_table_name "pr_personal_forms"

  belongs_to :person
  belongs_to :question_sheet

  def question_sheets
    [ question_sheet ]
  end
end
