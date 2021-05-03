FactoryBot.define do
  factory :account_user do
    admin { false }
    account { nil }
    user { nil }
  end
end
