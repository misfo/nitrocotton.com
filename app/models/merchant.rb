class Merchant < ActiveRecord::Base
  has_many :shirts, :dependent => :destroy do
    def new_from_url(url)
      page = proxy_owner.parser.new(url)
      new(
        :merchant_url => url,
        :name => page.name,
        :description => page.description,
        :min_price => page.min_price,
        :max_price => page.max_price,
        :image_url => page.image_url,
        :text => page.text_clue
      )
    end
  end

  def parser
    @parser ||= "ProductPage::#{name.gsub(/\s+/, '')}".constantize
  end
end
