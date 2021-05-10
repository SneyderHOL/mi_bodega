FactoryBot.define do
  factory :subscription do
    active { false }
    account { create(:account) }
    price { create(:price) }
    sequence(:stripe_subscription_id) { |n| "SbKySqmfgx98l1a#{n}ng" }
  end
end
