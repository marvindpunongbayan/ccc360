class CreateQuestionSheetPrInfos < ActiveRecord::Migration
  def self.up
    create_table :pr_question_sheet_pr_infos do |t|
      t.integer :question_sheet_id
      t.boolean :personal

      t.timestamps
    end
  end

  def self.down
    drop_table :pr_question_sheet_pr_infos
  end
end
