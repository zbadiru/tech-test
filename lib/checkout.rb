# Checkout class for handling item scanning and total calculation with discounts.
class Checkout
  attr_reader :prices, :discounts
  private :prices, :discounts

  # Initializes with a set of prices and optionally a set of discounts for specific items.
  # - prices: a hash with item symbols as keys and their prices as values.
  # - discounts: a hash where each item symbol maps to a specific Discount subclass instance.
  def initialize(prices, discounts = {})
    @prices = prices
    @discounts = discounts
  end

  # Scans an item, adding it to the basket for total calculation.
  def scan(item)
    basket << item.to_sym
  end

  # Calculates the total cost of the items in the basket, applying any discounts where applicable.
  def total
    # Manually tally item counts
    basket_count = Hash.new(0)
    basket.each { |item| basket_count[item] += 1 }

    # Sum the cost of each item type, applying discounts if available
    basket_count.sum do |item, count|
      discount = discounts[item] || Discount.new
      discount.apply(item, count, prices)
    end
  end

  private

  # Maintains an array of scanned items
  def basket
    @basket ||= []
  end
end
