class VotesController < ApplicationController
  def create
    @vote = Vote.find_or_initialize_by_user_id_and_shirt_id(
      user_session.user_id, params[:shirt_id])
    @vote.vote = params[:vote]
    @vote.save!

    @shirt = Shirt.find(:first,
      :conditions => ["shirts.id NOT IN (SELECT shirt_id FROM votes WHERE user_id = ?) AND shirts.id NOT IN (?)", user_session.user_id, user_session.teerack_ids],
      :include => :image, :order => "RANDOM()")

    if @vote.vote < 0
      user_session.teerack_ids.delete(@vote.shirt_id)
      user_session.teerack_ids << @shirt.id unless @shirt.nil?
    end
  end
end
