class RemoveKeyOnPagesNumber < ActiveRecord::Migration
  def self.up
    remove_key :pr_pages, :page, :number
  end

  def self.down
    add_key :pr_pages, :page, :number
  end
end
