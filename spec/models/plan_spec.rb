require 'rails_helper'

RSpec.describe Plan, type: :model do
  describe '#validations' do
    let(:plan) { build(:plan) }
    
    it 'test that factory object is valid' do
      expect(plan).to be_valid
    end

    it 'test that factory sequence is valid' do
      plan.save
      second_plan = build(:plan)
      expect(second_plan).to be_valid
    end

    it 'test for uniquenes' do
      aggregate_failures do
        plan.save
        second_plan = build(
          :plan,
          name: plan.name,
          stripe_product_id: plan.stripe_product_id
        )
        expect(second_plan).not_to be_valid
        expect(second_plan.errors[:name]).to include("has already been taken")
        expect(second_plan.errors[:stripe_product_id]).to(
          include("has already been taken")
        )
      end
    end

    it 'test that has no empty fields' do
      aggregate_failures do
        plan.name = ""
        plan.box_limit = nil
        plan.stripe_product_id = ""
        expect(plan).not_to be_valid
        expect(plan.errors[:name]).to include("can't be blank")
        expect(plan.errors[:box_limit]).to include("can't be blank")
        expect(plan.errors[:stripe_product_id]).to include("can't be blank")
      end
    end
  end
end
