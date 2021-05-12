require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe '#validations' do
    let(:free_subscription) { build(:free_subscription) }
    let(:moderate_subscription) { build(:moderate_subscription) }
    let(:unlimited_subscription) { build(:unlimited_subscription) }

    it 'test that factory object is valid' do
      expect(free_subscription).to be_valid
      expect(moderate_subscription).to be_valid
      expect(unlimited_subscription).to be_valid
    end

    it 'test that factory sequence is valid' do
      free_subscription.save
      second_free_subscription = build(:free_subscription)
      expect(second_free_subscription).to be_valid
    end

    it 'test for uniquenes' do
      aggregate_failures do
        free_subscription.save
        second_free_subscription = build(
          :subscription,
          account: free_subscription.account,
          stripe_subscription_id: free_subscription.stripe_subscription_id
        )
        expect(second_free_subscription).not_to be_valid
        expect(second_free_subscription.errors[:account]).to(
          include("has already been associated")
        )
        expect(second_free_subscription.errors[:stripe_subscription_id]).to(
          include("has already been taken")
        )
      end
    end

    it 'test that has no empty fields' do
      aggregate_failures do
        free_subscription.price = nil
        free_subscription.account = nil
        free_subscription.active = nil
        expect(free_subscription).not_to be_valid
        expect(free_subscription.errors[:active]).to include("must be true or false")
        expect(free_subscription.errors[:account]).to include("must exist")
        expect(free_subscription.errors[:price]).to include("must exist")
      end
    end
  end
end
