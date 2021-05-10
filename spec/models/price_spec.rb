require 'rails_helper'

RSpec.describe Price, type: :model do
  describe '#validations' do
    let(:price) { build(:price) }
    
    it 'test that factory object is valid' do
      expect(price).to be_valid
    end

    it 'test that factory sequence is valid' do
      price.save
      second_price = build(:price)
      expect(second_price).to be_valid
    end

    it 'test for uniquenes' do
      aggregate_failures do
        price.save
        second_price = build(
          :price,
          plan: price.plan,
          stripe_price_id: price.stripe_price_id
        )
        expect(second_price).not_to be_valid
        expect(second_price.errors[:plan]).to(
          include("has already been associated")
        )
        expect(second_price.errors[:stripe_price_id]).to(
          include("has already been taken")
        )
      end
    end

    it 'test that has no empty fields' do
      aggregate_failures do
        price.currency = ""
        price.amount = nil
        price.interval = ""
        price.stripe_price_id = ""
        price.plan = nil
        expect(price).not_to be_valid
        expect(price.errors[:currency]).to include("can't be blank")
        expect(price.errors[:amount]).to include("can't be blank")
        expect(price.errors[:interval]).to include("can't be blank")
        expect(price.errors[:stripe_price_id]).to include("can't be blank")
        expect(price.errors[:plan]).to include("must exist")
      end
    end
  end
end
