# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def rated_percentage
    number_to_percentage(100 * user_session.user.votes.size.to_f / total_shirt_count, :precision => 1)
  end
  
  def total_shirt_count
    @total_shirts_count ||= Shirt.count
  end
  
  def last_shirt_added_at
    @last_shirt_added_at ||= Shirt.maximum(:created_at)
  end
end
