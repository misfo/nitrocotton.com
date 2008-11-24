class CommentsController < ApplicationController
  before_filter :find_shirt

  def create
    @comment = @shirt.comments.build(params[:comment])

    if @comment.save
      flash[:notice] = "Your brilliance has been encapsulated into a comment and saved for posterity on this page"
      redirect_to @shirt
    else
      @shirt.comments(true)
      render :template => "shirts/show"
    end
  end

  protected
    def find_shirt
      @shirt = Shirt.find(params[:shirt_id])
    end
end
