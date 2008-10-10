module ShirtsHelper
  def price(number)
    number % 1 == 0 ? "$#{number.to_i}" : number_to_currency(number)
  end
  
  def price_range(min, max)
    [price(min), price(max)].uniq.join("-")
  end
end
