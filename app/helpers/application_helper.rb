# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def rated_percentage
    number_to_percentage(100 * user_session.user.votes.size.to_f / Shirt.count, :precision => 1)
  end
end
