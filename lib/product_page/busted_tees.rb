require 'open-uri'

class ProductPage::BustedTees < ProductPage::Base
  class << self
    def merchant_name() "Busted Tees" end

    def urls
      home_page = Hpricot(open("http://www.bustedtees.com"))
      relative_urls = (home_page / "#page_listing a").collect {|a| a[:href] }
      relative_urls.collect {|url| "http://www.bustedtees.com" + url }
    end
  end

  def name
    title = @page.at ".content h1"
    title.inner_html.strip
  end

  def description
    description = @page.at(".product_description p")
    description.search("span").remove
    remove_html(description.inner_html).strip
  end

  def prices
    @prices ||= begin
      json = @page.to_s[/^\s*product\.loadModels\(\{.+\}\s*,\s*(\{.+\})\s*\)\s*;\s*$/, 1]
      models = ActiveSupport::JSON.decode(json)
      models.values.collect {|m| m["price"] }.reject(&:blank?).collect(&:to_f)
    end
  end

  def min_price
    prices.min
  end

  def max_price
    prices.max
  end

  def image_url
    json = @page.to_s[/^\s*ProductImages\.load\((\{.+?\})\s*,\s*\{/, 1]
    product_images = ActiveSupport::JSON.decode(json)
    temp = product_images[product_images.keys.sort.first]
    product_image = temp[temp.keys.sort.first]
    product_image["artwork"]["large"]["url"]
  end
end
