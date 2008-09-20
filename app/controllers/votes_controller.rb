class VotesController < ApplicationController
  def create
    @vote = Vote.find_or_initialize_by_user_id_and_shirt_id(
      current_user_id, params[:shirt_id])
    @vote.vote = params[:vote]
    @vote.save!
  end
end
