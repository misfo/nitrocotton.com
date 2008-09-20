class AddIndexes < ActiveRecord::Migration
  def self.up
    add_index :votes, [:user_id, :shirt_id], :unique => true
    add_index :shirts, :merchant_url, :unique => true
  end

  def self.down
    remove_index :shirts, :column => :merchant_url
    remove_index :votes, :column => [:user_id, :shirt_id]
  end
end
