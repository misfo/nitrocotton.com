class ProductPage::SnorgTees < ProductPage::Base
  class << self
    def merchant_name() "Snorg Tees" end
 
    def urls
      home_page = Hpricot(open("http://www.snorgtees.com"))
      (home_page / ".infoBox .smallText a").collect {|a| a[:href][/^[^?]+/] }
    end
  end
 
  def name
    title = @page.at "td.pageHeading font"
    title.inner_html.strip
  end
 
  def description
    description = @page.at(".infoBox")
    description.inner_html.strip
  end
 
  def min_price
    @min_price ||= begin
      (@page / ".productSpecialPrice, td.pageHeading font").each do |font|
        text = font.inner_html.strip
        return text.sub("$", "") if text.starts_with?("$")
      end
    end
  end
 
  def max_price
    price_additions = (@page / "option").collect do |option|
      option.inner_html =~ /\(\+\$([\d.]+)\)/ ? $1.to_f : 0
    end
    min_price.to_f + (price_additions.max || 0)
  end
 
  def image_url
    thumbnails_iframe = (@page / "iframe").detect {|iframe| iframe[:name] == 'i_thumb' }
    thumbnails_page = open("http://www.snorgtees.com/#{thumbnails_iframe[:src]}").read
    filenames = thumbnails_page.scan(/['"]i_fullpic.php\?pi_fullpic=([^"']+)/).flatten
    filename = filenames.detect {|fn| fn =~ /\.gif$/i } || filenames[1]
    URI.escape("http://www.snorgtees.com/images/#{filename}")
  end
end