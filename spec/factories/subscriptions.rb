FactoryBot.define do
  factory :subscription do
    active { false }
    account { nil }
    price { nil }
  end
end
