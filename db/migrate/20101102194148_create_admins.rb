class CreateAdmins < ActiveRecord::Migration
  def self.up
    create_table "pr_admins" do |t|
      t.integer :person_id

      t.timestamps
    end
  end

  def self.down
    drop_table :admins
  end
end
