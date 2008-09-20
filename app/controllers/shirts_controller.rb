class ShirtsController < ApplicationController
  def index
    @shirts = Shirt.find(:all, :include => [:image, :votes, :comments], :limit => 16, :order => "RANDOM()")
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
end
