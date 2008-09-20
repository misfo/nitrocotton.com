class ChangeProductToShirt < ActiveRecord::Migration
  def self.up
    remove_index :products, :name => :index_products_on_merchant_url
    remove_index :products, :name => :index_votes_on_user_id_and_product_id
    rename_table :products, :shirts
    remove_column :shirts, :type
    rename_column :comments, :product_id, :shirt_id
    rename_column :images, :product_id, :shirt_id
    rename_column :votes, :product_id, :shirt_id
  end

  def self.down
    add_index "votes", ["user_id", "product_id"], :name => "index_votes_on_user_id_and_product_id", :unique => true
    add_index "products", ["merchant_url"], :name => "index_products_on_merchant_url"
    rename_column :votes, :shirt_id, :product_id
    rename_column :images, :shirt_id, :product_id
    rename_column :comments, :shirt_id, :product_id
    add_column :shirts, :type, :string
    rename_table :shirts, :products
  end
end
