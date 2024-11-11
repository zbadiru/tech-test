
# Base Discount class for different discount strategies
class Discount
  def apply(item, count, prices)
    prices.fetch(item) * count
  end
end


# Buy One Get One Free
class BuyOneGetOneFree < Discount
  def apply(item, count, prices)
    (count / 2 + count % 2) * prices.fetch(item)
  end
end

# Buy 3 Get 1 Free
class BuyThreeGetOneFree < Discount
  def apply(item, count, prices)
    (count - count / 4) * prices.fetch(item)
  end
end


# Checkout class with refactored discount handling
class Checkout
  attr_reader :prices, :discounts
  private :prices, :discounts

  def initialize(prices, discounts = {})
    @prices = prices
    @discounts = discounts
  end

  # Add an item to the basket
  def scan(item)
    basket << item.to_sym
  end

  # Calculate the total price with applicable discounts
  # Tally counts of each item in the basket
  # Sum up the price per item after applying the relevant discount strategy
  # Select the discount strategy for the item, defaulting to no discount
  def total
    basket_count = basket.tally
    basket_count.sum do |item, count|
      discount = discounts.fetch(item, Discount.new)
      discount.apply(item, count, prices)
    end
  end

  private

  # Initialize or retrieve the basket array
  def basket
    @basket ||= []
  end
end
