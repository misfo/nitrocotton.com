class RenameShirtProduct < ActiveRecord::Migration
  def self.up
    remove_index  :shirts, :product_url

    rename_table :shirts, :products

    rename_column :images, :shirt_id, :product_id

    # this just makes more sense
    rename_column :products, :product_url, :merchant_url
    add_index     :products, :merchant_url
  end

  def self.down
    remove_index  :products, :merchant_url

    rename_table :products, :shirts

    rename_column :images, :product_id, :shirt_id

    rename_column :shirts, :merchant_url, :product_url
    add_index     :shirts, :product_url
  end
end
