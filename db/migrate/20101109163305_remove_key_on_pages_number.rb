class RemoveKeyOnPagesNumber < ActiveRecord::Migration
  def self.up
    remove_index Page.table_name, :name => "page_number"
  end

  def self.down
    add_index Page.table_name, [:question_sheet_id, :number], :name => "page_number", :unique => true
  end
end
