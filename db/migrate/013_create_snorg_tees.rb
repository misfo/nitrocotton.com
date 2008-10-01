class CreateSnorgTees < ActiveRecord::Migration
  def self.up
    Merchant.create!(:name => "Snorg Tees", :homepage_url => "http://www.snorgtees.com")
  end

  def self.down
    Merchant.destroy_all(:homepage_url => "http://www.snorgtees.com")
  end
end
