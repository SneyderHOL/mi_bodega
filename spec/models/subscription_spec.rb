require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe '#validations' do
    let(:subscription) { build(:subscription) }
    
    it 'test that factory object is valid' do
      expect(subscription).to be_valid
    end

    it 'test that factory sequence is valid' do
      subscription.save
      second_subscription = build(:subscription)
      expect(second_subscription).to be_valid
    end

    it 'test for uniquenes' do
      aggregate_failures do
        subscription.save
        second_subscription = build(
          :subscription,
          account: subscription.account,
          stripe_subscription_id: subscription.stripe_subscription_id
        )
        expect(second_subscription).not_to be_valid
        expect(second_subscription.errors[:account]).to(
          include("has already been associated")
        )
        expect(second_subscription.errors[:stripe_subscription_id]).to(
          include("has already been taken")
        )
      end
    end

    it 'test that has no empty fields' do
      aggregate_failures do
        subscription.price = nil
        subscription.account = nil
        subscription.active = nil
        expect(subscription).not_to be_valid
        expect(subscription.errors[:active]).to include("must be true or false")
        expect(subscription.errors[:account]).to include("must exist")
        expect(subscription.errors[:price]).to include("must exist")
      end
    end
  end
end
