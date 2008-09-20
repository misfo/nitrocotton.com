class AddShirtIdToImage < ActiveRecord::Migration
  def self.up
    add_column :images, :shirt_id, :integer
  end

  def self.down
    remove_column :images, :shirt_id
  end
end
