class ShirtsController < ApplicationController
  
  def index
    respond_to do |format|
      format.html do
        @shirts = Shirt.
          unvoted_and_voted_up_by(user_session.user_id).
          all(:include => :image, :limit => 16, :order => "vote DESC, RANDOM()")
      end
      format.rss do
        @shirts = Shirt.all(:limit => 50, :order => "created_at DESC")
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
    @celeb_vote = @shirt.celeb_votes.find_or_initialize_by_user_id(user_session.user_id)
    @comment = Comment.new
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
