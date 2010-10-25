class AddSessionStore < ActiveRecord::Migration
  def self.up
    create_table :pr_sessions do |t|
      t.integer :id
      t.text :session_id
      t.text :data
    end
  end

  def self.down
    drop_table :pr_sessions
  end
end
