class CreatePersonalForms < ActiveRecord::Migration
  def self.up
    create_table :pr_personal_forms do |t|
      t.integer :person_id
      t.integer :question_sheet_id

      t.timestamps
    end
  end

  def self.down
    drop_table :personal_forms
  end
end
