FactoryBot.define do
  factory :price do
    currency { "MyString" }
    amount { 1 }
    interval { "MyString" }
    stripe_price_id { "MyString" }
    plan { nil }
  end
end
