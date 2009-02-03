class AdminController < ApplicationController

  before_filter :authenticate
  
  def index
  end

  def merchant_update
    @merchant = Merchant.find(params[:id])
    
    @urls      = @merchant.parser.urls
    @real_urls = @urls - IgnorableProduct.find_all_urls
    @new_urls  = begin
      existing_urls = @merchant.shirts.collect {|s| s.merchant_url.downcase }
      @real_urls.reject {|u| existing_urls.include?(u.downcase) }
    end
  end

  def ignore_url
    IgnorableProduct.create!(:url => params[:url])
  end

  def fetch_shirt_info
    @merchant = Merchant.find(params[:merchant_id])
    @shirt = @merchant.shirts.new_from_url(params[:url])
  end

  private
    def authenticate
      authenticate_or_request_with_http_basic do |user_name, password|
        user_name == "misfo" && password == "MoreShirts"
      end
    end

end
