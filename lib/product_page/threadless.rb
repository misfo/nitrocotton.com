require 'feed-normalizer'

class ProductPage::Threadless < ProductPage::Base
  class << self
    def merchant_name() "Threadless" end

    def urls
      in_stock_feed = FeedNormalizer::FeedNormalizer.parse(
        open("http://feeds.feedburner.com/ThreadlessInStock"))
      in_stock_feed.entries.collect {|entry| entry.urls.first }
    end
  end

  def name
    (@page/"head/title").inner_html[/\s+-\s+(.+?)\s+by\s+/, 1]
  end

  def description
    td = (@page/"/html/body/div[11]/table/tr/td/div/table/tr/td/table/tr[2]/td[3]")
    td.search("div").remove
    desc = td.inner_text.strip.gsub(/\s+/, " ")
    desc unless desc == "The designer hasn't written about this product."
  end

  def prices
    @prices ||= (@page / "div.product_stock_price img").collect do |img|
      img[:alt].gsub(/\$/, "").to_i
    end
  end

  def min_price
    prices.min
  end

  def max_price
    prices.max
  end

  def image_url
    @page.at("//a[@href='#top']/img")[:src]
  end
end
