class CreatePersonAccesses < ActiveRecord::Migration
  def self.up
    create_table :person_accesses do |t|
      t.boolean :national_access
      t.boolean :regional_access
      t.boolean :ics_access
      t.boolean :intern_access
      t.boolean :stint_access
      t.boolean :mtl_access
      t.integer :person_id

      t.timestamps
    end
  end

  def self.down
    drop_table :person_accesses
  end
end
