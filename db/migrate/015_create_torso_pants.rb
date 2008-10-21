class CreateTorsoPants < ActiveRecord::Migration
  def self.up
    Merchant.create!(:name => "TorsoPants", :homepage_url => "http://www.torsopants.com")
  end

  def self.down
    Merchant.destroy_all(:homepage_url => "http://www.torsopants.com")
  end
end
