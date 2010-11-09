class RemoveKeyOnPagesNumber < ActiveRecord::Migration
  def self.up
    remove_index :pr_pages, [ :page, :number ]
  end

  def self.down
    add_index :pr_pages, [ :page, :number ]
  end
end
