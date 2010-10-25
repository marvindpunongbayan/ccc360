class AddNameAndPurposeToReviews < ActiveRecord::Migration
  def self.up
    add_column Review.table_name, :name, :string
    add_column Review.table_name, :purpose, :string
  end

  def self.down
    remove_column Review.table_name, :name, :string
    remove_column Review.table_name, :purpose, :string
  end
end
