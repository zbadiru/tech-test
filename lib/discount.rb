# Base Discount class for applying different discount strategies.
# Each subclass will override the `apply` method with specific discount logic.
class Discount
        # Calculates the price for items without any discounts.
        def apply(item, count, prices)
        prices.fetch(item) * count
        end
    end
    
    # Buy One Get One Free Discount
    # This discount charges only for half the items (rounded up), providing every second item for free.
    class BuyOneGetOneFree < Discount
        def apply(item, count, prices)
        # Charges for half the items, rounding up if there's an odd number.
        (count / 2 + count % 2) * prices.fetch(item)
        end
    end
    
    # Buy 3 Get 1 Free Discount
    # This discount makes every fourth item free.
    class BuyThreeGetOneFree < Discount
        def apply(item, count, prices)
        # Charges for 3 out of every 4 items.
        (count - count / 4) * prices.fetch(item)
        end
    end
    
    # Half Price Discount
    # Reduces the price of each item by half.
    class HalfPriceDiscount < Discount
        def apply(item, count, prices)
        # Each item is half price
        (prices.fetch(item) / 2.0) * count
        end
    end