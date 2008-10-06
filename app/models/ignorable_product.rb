class IgnorableProduct < ActiveRecord::Base
  def self.find_all_urls
    connection.select_values "SELECT url FROM ignorable_products"
  end
end
