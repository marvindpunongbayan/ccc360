class CreateSummaryForms < ActiveRecord::Migration
  def self.up
    create_table :pr_summary_forms do |t|
      t.integer :person_id
      t.integer :review_id
      t.timestamps
    end
  end

  def self.down
    drop_table :pr_summary_forms
  end
end
