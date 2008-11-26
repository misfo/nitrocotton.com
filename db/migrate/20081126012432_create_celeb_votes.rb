class CreateCelebVotes < ActiveRecord::Migration
  def self.up
    create_table :celeb_votes do |t|
      t.integer :shirt_id, :celebrity_id, :user_id

      t.timestamps
    end

    add_index :celeb_votes, [:user_id, :shirt_id], :unique => true
  end

  def self.down
    drop_table :celeb_votes
  end
end
