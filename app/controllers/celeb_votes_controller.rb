class CelebVotesController < ApplicationController
  before_filter :find_shirt

  def create
    @celeb_vote = CelebVote.find_or_initialize_by_user_id_and_shirt_id(user_session.user.id, @shirt.id)

    @celeb_vote.update_attribute(:celebrity_id, params[:celeb_vote][:celebrity_id])
    redirect_to @shirt
  end

  protected
    def find_shirt
      @shirt = Shirt.find(params[:shirt_id])
    end
end
