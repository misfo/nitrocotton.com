class ProductPage::TorsoPants < ProductPage::Base
  class << self
    def merchant_name() "Torso Pants" end
 
    def urls
      home_page = Hpricot(open("http://www.torsopants.com/main/"))
      divs = (home_page / "#thumbtable div").select {|div| div[:id] == "littlethumb" }
      divs.collect {|div| "http://www.torsopants.com" + div.at("a")[:href] }
    end
  end
 
  def name
    title = @page.at "title"
    title.inner_html.strip.sub(/\Atorsopants\W+/i, "").titleize
  end
 
  def description
    description = @page.at(".nutfact")
    description.inner_html.strip
  end
 
  def min_price
    19
  end
 
  def max_price
    additions = (@page / "option").collect {|option| option.inner_html[/\(\+\$(\d+)\)/, 1] }
    max_addition = additions.compact.collect(&:to_f).max
    min_price + max_addition
  end
 
  def image_url
    home_page = Hpricot(open("http://www.torsopants.com/main/"))
    links = (home_page / "#thumbtable div a")
    link = links.detect {|a| @url.ends_with?(a[:href]) }
    relative_filename = link.at("img")[:src]
    "http://www.torsopants.com#{relative_filename}"
  end
end
