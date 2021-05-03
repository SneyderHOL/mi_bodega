FactoryBot.define do
  factory :plan do
    name { "MyString" }
    box_limit { 1 }
    stripe_product_id { "MyString" }
  end
end
