class AdminController < ApplicationController

  before_filter :authenticate
  
  def index
  end

  def merchant_update
    @merchant = Merchant.find(params[:id])
    
    @urls      = @merchant.parser.urls
    @real_urls = @urls - IgnorableProduct.find_all_urls
    @new_urls  = (@real_urls - @merchant.shirts.collect(&:merchant_url)).reject {|u| @merchant.shirts.page_exists?(u) }
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
      authenticate_or_request_with_http_basic do |username, password|
        [username, password] == admin_credentials.values_at('username', 'password')
      end
    end

    def admin_credentials
      @admin_credentials ||= YAML::load_file(File.join(Rails.root, "config", "admin.yml"))
    end

end
