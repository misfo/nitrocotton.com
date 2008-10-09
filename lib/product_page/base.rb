require 'open-uri'
require 'hpricot'

class ProductPage::Base

  class << self
    def new(url)
      raise TypeError, "ProductPage::Base cannot be instantiated" if self == ProductPage::Base
      super
    end

    def merchant
      @merchant ||= Merchant.find_by_name(merchant_name)
    end

    def all
      #FIXME the urls are limited for testing
      urls.first(25).collect {|url| new(url) }
    end

    def save_all!
      puts "Parsing the pages"
      pages = all
      puts "\nUpdating the database"
      pages.each(&:save!)
    end
  end
  
  attr_reader :url

  def initialize(product_url)
    @url = product_url
    @page = Hpricot(open(url))
  end
  
  def text_clue
    name
  end

  def save!
    product = Shirt.find_or_initialize_by_merchant_url(url)
    product.update_attributes!(
      :name        => name,
      :description => description,
      :min_price   => min_price,
      :max_price   => max_price,
      :merchant    => self.class.merchant
    )
    #TODO decide when to update an existing image
    unless product.image
      image = product.build_image
      image.update_file(image_url)
      image.save!
    end
  end

  protected
    def remove_html(str)
      str.gsub(/<\/?[^>]*>/, "").strip
    end
end
