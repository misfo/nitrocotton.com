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
  end
  
  attr_reader :url

  def initialize(product_url)
    @url = product_url
    @page = Hpricot(open(url))
  end
  
  def text_clue
    name
  end

  protected
    def remove_html(str)
      str.gsub(/<\/?[^>]*>/, "").strip
    end
end
