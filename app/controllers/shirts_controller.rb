class ShirtsController < ApplicationController
  
  def index
    respond_to do |format|
      format.html do
        @shirts = Shirt.not_voted_down_by(user_session.user_id).all(:include => :image, :limit => 16, :order => "RANDOM()")
        user_session.teerack_ids = @shirts.collect(&:id)
      end
      format.rss do
        @shirts = Shirt.all(:order => "created_at DESC")
      end
    end
  end

  def show
    @shirt = Shirt.find(params[:id])
  end
  
  def random
    @shirt = Shirt.find(:first, :order => "RANDOM()")
    render :action => 'show'
  end

  def create
    @shirt = Shirt.new(params[:shirt])

    @shirt.save!
  end

  def update
    @shirt = Shirt.find(params[:id])

    @shirt.update_attributes!(params[:shirt])
  end
end
