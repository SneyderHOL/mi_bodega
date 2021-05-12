FactoryBot.define do
  factory :subscription do
    active { true }
    sequence(:stripe_subscription_id) { |n| "SbKySqmfgx98l1a#{n}ng" }
    account { create(:account) }
    factory :free_subscription do
      price { create(:free_price) }
    end
    factory :moderate_subscription do
      price { create(:moderate_price) }
    end
    factory :unlimited_subscription do
      price { create(:unlimited_price) }
    end
  end
end
