class CreateIgnorableProducts < ActiveRecord::Migration
  def self.up
    create_table :ignorable_products do |t|
      t.string :url

      t.timestamps
    end
  end

  def self.down
    drop_table :ignorable_products
  end
end
