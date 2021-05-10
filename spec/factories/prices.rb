FactoryBot.define do
  factory :price do
    currency { "usd" }
    amount { 1000 }
    interval { "Month" }
    sequence(:stripe_price_id) { |n| "PrKySqmfgx98l1a#{n}ng" }
    plan { create(:plan) }
  end
end
