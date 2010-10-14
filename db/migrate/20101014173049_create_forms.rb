class CreateForms < ActiveRecord::Migration
  def self.up
    create_table :pr_forms do |t|
      t.string :name
      t.boolean :archived
      t.boolean :personal

      t.timestamps
    end
  end

  def self.down
    drop_table :pr_forms
  end
end
