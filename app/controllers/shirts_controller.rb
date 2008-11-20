class ShirtsController < ApplicationController
  after_filter :update_teerack_ids, :only => [:index, :fresh, :da_best]
  
  def index
    respond_to do |format|
      format.html do
        @shirts = Shirt.not_voted_down_by(user_session.user_id).all(:include => :image, :limit => 16, :order => "RANDOM()")
      end
      format.rss do
        @shirts = Shirt.all(:order => "created_at DESC")
      end
    end
  end

  def fresh
    @shirts = Shirt.all(:include => :image, :limit => 16, :order => "created_at DESC")
    render :action => 'index'
  end

  def da_best
    @shirts = Shirt.highest_rated.all(:limit => 16)
    render :action => 'index'
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

  protected
    def update_teerack_ids
      unless params[:format] && params[:format] != "html"
        user_session.teerack_ids = @shirts.collect(&:id)
      end
    end
end
