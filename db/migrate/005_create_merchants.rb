class CreateMerchants < ActiveRecord::Migration
  def self.up
    create_table :merchants do |t|
      t.string :name, :homepage_url

      t.timestamps
    end

    Merchant.create(:name => "Threadless",  :homepage_url => "http://www.threadless.com")
    Merchant.create(:name => "Busted Tees", :homepage_url => "http://www.bustedtees.com")

    add_column :products, :merchant_id, :integer
  end

  def self.down
    add_column :products, :merchant_id

    drop_table :merchants
  end
end
