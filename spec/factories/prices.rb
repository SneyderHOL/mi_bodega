FactoryBot.define do
  factory :price do
    currency { "usd" }
    interval { "Month" }
    sequence(:stripe_price_id) { |n| "PrKySqmfgx98l1a#{n}ng" }
    factory :free_price do
      amount { 0 }
      plan { create(:free_plan) }
    end
    factory :moderate_price do
      amount { 2500 }
      plan { create(:moderate_plan) }
    end
    factory :unlimited_price do
      amount { 5000 }
      plan { create(:unlimited_plan) }
    end
  end
end
