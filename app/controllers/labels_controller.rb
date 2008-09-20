class LabelsController < ApplicationController
  def create
    @label = Label.new(params[:label])
    @shirt = Shirt.find(params[:shirt_id])

    @label.save!
  end
end
