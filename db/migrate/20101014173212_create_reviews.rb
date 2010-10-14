class CreateReviews < ActiveRecord::Migration
  def self.up
    create_table :pr_reviews do |t|
      t.integer :subject_id
      t.integer :initiator_id
      t.string :status
      t.integer :percent
      t.date :due

      t.timestamps
    end
  end

  def self.down
    drop_table :pr_reviews
  end
end
