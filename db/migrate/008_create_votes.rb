class CreateVotes < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
      t.integer :user_id, :product_id, :vote, :null => false
      t.timestamps
    end

    add_index :votes, [:user_id, :product_id], :unique => true
  end

  def self.down
    drop_table :votes
  end
end
