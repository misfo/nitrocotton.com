module ShirtsHelper
  def price(number)
    number % 1 == 0 ? "$#{number.to_i}" : number_to_currency(number)
  end
  
  def price_range(min, max)
    [price(min), price(max)].uniq.join("-")
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
