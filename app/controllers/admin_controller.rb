class AdminController < ApplicationController

  def index
  end

  def merchant_update
    @merchant = Merchant.find(params[:id])
    
    @urls      = @merchant.parser.urls
    @real_urls = @urls - IgnorableProduct.find_all_urls
    @new_urls  = @real_urls - @merchant.shirts.collect(&:merchant_url)
  end

  def ignore_url
    IgnorableProduct.create!(:url => params[:url])
  end

  def fetch_shirt_info
    @merchant = Merchant.find(params[:merchant_id])
    @shirt = @merchant.shirts.new_from_url(params[:url])
  end
end
