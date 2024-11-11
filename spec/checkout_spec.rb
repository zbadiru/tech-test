require 'spec_helper'
require 'checkout'

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

    context 'when no offers apply' do
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

      it 'returns the discounted price for the basket' do
        expect(total).to eq(10)
      end
    end

    context 'when a Buy 3 Get 1 Free discount applies on mangoes' do
      let(:discounts) { { mango: BuyThreeGetOneFree.new } }

      before do
        checkout.scan(:mango)
        checkout.scan(:mango)
        checkout.scan(:mango)
        checkout.scan(:mango)
      end

      it 'returns the discounted price for the mangoes' do
        expect(total).to eq(600) # 3 paid, 1 free
      end
    end
  end
end
