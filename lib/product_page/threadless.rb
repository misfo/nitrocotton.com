class ProductPage::Threadless < ProductPage::Base
  class << self
    def merchant_name() "Threadless" end

    def urls
      typetees_page = Hpricot(open("http://www.threadless.com/catalog/line,typetees"))
      links = (typetees_page / ".catalog_titleby a")
      links.collect {|a| "http://www.threadless.com#{a[:href]}" }
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
    @prices ||= (@page / ".product_type img").collect do |img|
      if img[:src] =~ /\/price\/(\d+)\.[a-z]{3}$/
        $1.to_i
      end
    end.compact
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
