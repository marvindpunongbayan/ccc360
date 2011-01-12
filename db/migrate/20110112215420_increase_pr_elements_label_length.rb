class IncreasePrElementsLabelLength < ActiveRecord::Migration
  def self.up
    change_column :pr_elements, :label, :string, :limit => 1000
  end

  def self.down
    change_column :pr_elements, :label, :string, :limit => 255
  end
end
