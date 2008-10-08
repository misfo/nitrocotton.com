class ShirtsController < ApplicationController
  
  def index
    @shirts = Shirt.find(:all,
      :conditions => ["shirts.id NOT IN (SELECT shirt_id FROM votes WHERE user_id = ?)", user_session.user_id],
      :include => :image, :limit => 8, :order => "RANDOM()")
    user_session.teerack_ids = @shirts.collect(&:id)
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
