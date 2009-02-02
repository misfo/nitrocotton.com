class ProductPage::Threadless < ProductPage::Base
  class << self
    def merchant_name() "Threadless" end

    def urls
      typetees_page = Hpricot.XML(open("http://feeds.feedburner.com/TypeTees"))
      (typetees_page / "feedburner:origLink").collect(&:inner_html)
    end
  end

  def name
    (@page/"head/title").inner_html.sub(/^TypeTees -  T-shirt: /, "")
  end

  def description
    nil
  end

  def price
    @price ||= (@page / "span.f_18").each do |span|
      return $1.to_i if span.inner_html =~ /^\$([\d\.]+)/
    end
  end

  def min_price
    price
  end

  def max_price
    price
  end

  def image_url
    #"http://www.typetees.com/product/#{threadless_id}/minizoom.jpg"
    "http://media.threadless.com//product/#{threadless_id}/zoom.gif"
  end
  
  def threadless_id
    @url[/\/product\/(\d+)\//, 1]
  end
end
