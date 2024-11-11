require 'spec_helper'
require 'checkout'
require 'discount'

RSpec.describe Checkout do
  describe '#total' do
    subject(:total) { checkout.total }

    let(:pricing_rules) {
      {
        apple: 10,
        orange: 20,
        pear: 15,
        banana: 30,
        pineapple: 100,
        mango: 200
      }
    }

    let(:checkout) { Checkout.new(pricing_rules, discounts) }
    let(:discounts) { {} }

    context 'when no discounts apply' do
      before do
        checkout.scan(:apple)
        checkout.scan(:orange)
      end

      it 'returns the base price for the basket' do
        expect(total).to eq(30)
      end
    end

    context 'when a Buy One Get One Free discount applies on apples' do
      let(:discounts) { { apple: BuyOneGetOneFree.new } }

      before do
        checkout.scan(:apple)
        checkout.scan(:apple)
      end

      it 'applies the discount correctly' do
        expect(total).to eq(10) # One apple is free
      end
    end

    context 'when a Buy 3 Get 1 Free discount applies on mangos' do
      let(:discounts) { { mango: BuyThreeGetOneFree.new } }

      before do
        checkout.scan(:mango)
        checkout.scan(:mango)
        checkout.scan(:mango)
        checkout.scan(:mango)
      end

      it 'applies the Buy 3 Get 1 Free discount correctly' do
        expect(total).to eq(600) # 3 mangoes paid, 1 is free
      end
    end

    context 'when a Half Price discount applies on pineapples' do
      let(:discounts) { { pineapple: HalfPriceDiscount.new } }

      before do
        checkout.scan(:pineapple)
        checkout.scan(:pineapple)
      end

      it 'applies the Half Price discount correctly' do
        expect(total).to eq(100) # Each pineapple is half price, so 50 each
      end
    end
  end
end
