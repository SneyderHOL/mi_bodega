FactoryBot.define do
  factory :plan do
    sequence(:name) { |n| "plan-#{n}" }
    box_limit { 1 }
    sequence(:stripe_product_id) { |n| "PKySqmfgx98l1a#{n}ng" }
  end
end
