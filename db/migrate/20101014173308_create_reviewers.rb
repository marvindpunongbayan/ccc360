class CreateReviewers < ActiveRecord::Migration
  def self.up
    create_table :pr_reviewers do |t|
      t.integer :review_id
      t.integer :person_id
      t.datetime :invitation_sent_at

      t.timestamps
    end
  end

  def self.down
    drop_table :pr_reviewers
  end
end
