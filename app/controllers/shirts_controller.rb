class ShirtsController < ApplicationController
  after_filter :record_shirts_viewed, :only => :index
  
  def index
    @shirts = Shirt.find_all_with_preference(
      :prefer_high_rated => user_session.impress_me?,
      :avoid_ids => user_session.viewed_shirt_ids,
      :include => [:image, :votes],
      :limit => 8)
  end

  def show
    @shirt = Shirt.find(params[:id])
  end

  def create
    @shirt = Shirt.new(params[:shirt])

    @shirt.save!
  end

  def update
    @shirt = Shirt.find(params[:id])

    @shirt.update_attributes!(params[:shirt])
  end
  
protected
  def record_shirts_viewed
    user_session.viewed_shirts(@shirts)
  end
end
