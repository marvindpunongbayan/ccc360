class CreatePrUsers < ActiveRecord::Migration
  def self.up
    create_table :pr_users do |t|
      t.integer :ssm_id
      t.datetime :last_login

      t.timestamps
    end
  end

  def self.down
    drop_table :pr_users
  end
end
