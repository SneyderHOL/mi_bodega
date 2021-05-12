require 'rails_helper'

RSpec.describe Plan, type: :model do
  describe '#validations' do
    let(:free_plan) { build(:free_plan) }
    let(:moderate_plan) { build(:moderate_plan) }
    let(:unlimited_plan) { build(:unlimited_plan) }
    
    it 'test that factory object is valid' do
      expect(free_plan).to be_valid
      expect(moderate_plan).to be_valid
      expect(unlimited_plan).to be_valid
    end

    it 'test that factory sequence is valid' do
      free_plan.save
      second_free_plan = build(:free_plan)
      expect(second_free_plan).to be_valid
    end

    it 'test for uniquenes' do
      aggregate_failures do
        free_plan.save
        second_free_plan = build(
          :plan,
          name: free_plan.name,
          stripe_product_id: free_plan.stripe_product_id
        )
        expect(second_free_plan).not_to be_valid
        expect(second_free_plan.errors[:name]).to include("has already been taken")
        expect(second_free_plan.errors[:stripe_product_id]).to(
          include("has already been taken")
        )
      end
    end

    it 'test that has no empty fields' do
      aggregate_failures do
        free_plan.name = ""
        free_plan.box_limit = nil
        free_plan.stripe_product_id = ""
        expect(free_plan).not_to be_valid
        expect(free_plan.errors[:name]).to include("can't be blank")
        expect(free_plan.errors[:box_limit]).to include("can't be blank")
        expect(free_plan.errors[:stripe_product_id]).to include("can't be blank")
      end
    end
  end
end
