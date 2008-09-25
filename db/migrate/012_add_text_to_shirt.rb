class AddTextToShirt < ActiveRecord::Migration
  def self.up
    add_column :shirts, :text, :text
  end

  def self.down
    remove_column :shirts, :text
  end
end
