module ShirtsHelper
  def price(number)
    if price.nil? || price.zero?
      nil
    elsif number % 1 == 0
      "$#{number.to_i}"
    else
      number_to_currency(number)
    end
  end
  
  def price_range(min, max)
    [price(min), price(max)].compact.uniq.join("-")
  end
  
  def vote_bar_width(votes)
    # assumes it gets the highest number of votes first
    @max_votes ||= votes.to_i.to_f
    (votes.to_i / @max_votes * 145).round
  end

  def vote_class(up_or_down, shirt)
    voted = teerack_votes.any? {|v| v.shirt_id == shirt.id && v.send("#{up_or_down}?") }
    "thumbs_#{up_or_down}#{' voted' if voted}"
  end
  
  protected
    def teerack_votes
      @teerack_votes ||= user_session.user.votes.find_all_by_shirt_id(@shirts.collect(&:id))
    end
end
