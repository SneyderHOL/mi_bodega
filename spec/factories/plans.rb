FactoryBot.define do
  factory :plan do
    sequence(:name) { |n| "plan-#{n}" }
    sequence(:stripe_product_id) { |n| "PKySqmfgx98l1a#{n}ng" }
    factory :free_plan do
      box_limit { 1 }
    end
    factory :moderate_plan do
      box_limit { 5 }
    end
    factory :unlimited_plan do
      box_limit { 0 }
    end
  end
end
