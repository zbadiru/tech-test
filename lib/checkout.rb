# Base Discount class for different discount strategies
class Discount
  def apply(item, count, prices)
    prices.fetch(item) * count
  end
end

# Buy One Get One Free Discount
class BuyOneGetOneFree < Discount
  def apply(item, count, prices)
    (count / 2 + count % 2) * prices.fetch(item)
  end
end

# Buy 3 Get 1 Free Discount
class BuyThreeGetOneFree < Discount
  def apply(item, count, prices)
    (count - count / 4) * prices.fetch(item)
  end
end

# Checkout class with dynamic discount handling
class Checkout
  attr_reader :prices, :discounts
  private :prices, :discounts

  # Initialize with prices and an optional discounts hash
  def initialize(prices, discounts = {})
    @prices = prices
    @discounts = discounts
  end

  # Add an item to the basket
  def scan(item)
    basket << item.to_sym
  end

  # Calculate the total price with applicable discounts
  def total
    # Manually tally item counts
    basket_count = Hash.new(0)
    basket.each { |item| basket_count[item] += 1 }

    # Sum up the price per item after applying the relevant discount strategy
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
