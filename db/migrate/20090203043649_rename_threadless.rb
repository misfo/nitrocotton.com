class RenameThreadless < ActiveRecord::Migration
  def self.up
    m = Merchant.find_by_name("Threadless")
    m.update_attributes(:name => "TypeTees", :homepage_url => "http://www.typetees.com")
  end

  def self.down
    m = Merchant.find_by_name("TypeTees")
    m.update_attributes(:name => "Threadless", :homepage_url => "http://www.threadless.com")
  end
end
