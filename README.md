Checkout System
This project is a basic checkout system designed to handle item scanning, pricing, and discount application. The system includes several discount strategies (e.g., Buy One Get One Free, Buy 3 Get 1 Free, Half Price) and allows dynamic assignment of discounts to different items.

Features
Dynamic Discount Assignment: Allows specific discounts to be applied to items dynamically.
Extensible Discount Strategies: Each discount strategy (e.g., Buy One Get One Free) is implemented as a separate class for easy addition of new discount types.
Easy-to-Use Checkout Interface: Provides straightforward methods for scanning items and calculating totals.
Getting Started

Prerequisites
Ruby: Ensure you have Ruby installed. You can check your Ruby version with:
    ruby -v

Install Dependencies: If there are any dependencies in the Gemfile, install them with:
    bundle install

Running Tests: The project includes RSpec tests. To run the tests, use:
    rspec spec

Folder Structure

lib/checkout.rb: Main class for handling item scanning and total calculation.
lib/discount.rb: Contains discount strategies, including Buy One Get One Free, Buy 3 Get 1 Free, and Half Price discounts.
spec/: RSpec tests for validating checkout and discount functionality.

Explanation of Discounts

Buy One Get One Free: Applied to apples; every second apple is free.
Buy 3 Get 1 Free: Applied to mangos; every fourth mango is free.
Half Price: Applied to pineapples; each pineapple is half price.

Acknowledgments

This project is based on a backend engineering code test, focusing on refactoring legacy code and applying design principles like the strategy pattern for maintainability.