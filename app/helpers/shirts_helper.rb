module ShirtsHelper
  def price(number)
    number % 1 == 0 ? "$#{number.to_i}" : number_to_currency(number)
  end
  
  def price_range(min, max)
    [price(min), price(max)].uniq.join("-")
  end

  def vote_class(up_or_down, shirt)
    voted = user_session.teerack_votes.any? do |v|
      v.shirt_id == shirt.id && v.send("#{up_or_down}?")
    end
    "thumbs_#{up_or_down}#{' voted' if voted}"
  end
end
