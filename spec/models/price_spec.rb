require 'rails_helper'

RSpec.describe Price, type: :model do
  describe '#validations' do
    let(:free_price) { build(:free_price) }
    let(:moderate_price) { build(:moderate_price) }
    let(:unlimited_price) { build(:unlimited_price) }
    
    it 'test that factory object is valid' do
      expect(free_price).to be_valid
      expect(moderate_price).to be_valid
      expect(unlimited_price).to be_valid
    end

    it 'test that factory sequence is valid' do
      free_price.save
      second_free_price = build(:free_price)
      expect(second_free_price).to be_valid
    end

    it 'test for uniquenes' do
      aggregate_failures do
        free_price.save
        second_free_price = build(
          :price,
          plan: free_price.plan,
          stripe_price_id: free_price.stripe_price_id
        )
        expect(second_free_price).not_to be_valid
        expect(second_free_price.errors[:plan]).to(
          include("has already been associated")
        )
        expect(second_free_price.errors[:stripe_price_id]).to(
          include("has already been taken")
        )
      end
    end

    it 'test that has no empty fields' do
      aggregate_failures do
        free_price.currency = ""
        free_price.amount = nil
        free_price.interval = ""
        free_price.stripe_price_id = ""
        free_price.plan = nil
        expect(free_price).not_to be_valid
        expect(free_price.errors[:currency]).to include("can't be blank")
        expect(free_price.errors[:amount]).to include("can't be blank")
        expect(free_price.errors[:interval]).to include("can't be blank")
        expect(free_price.errors[:stripe_price_id]).to include("can't be blank")
        expect(free_price.errors[:plan]).to include("must exist")
      end
    end
  end
end
