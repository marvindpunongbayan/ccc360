class AllowPrAnswerSheetsQsIdToBeNull < ActiveRecord::Migration
  def up
  	change_column :pr_answer_sheets, :question_sheet_id, :integer, :null => true
  end

  def down
  	change_column :pr_answer_sheets, :question_sheet_id, :integer, :null => false
  end
end
