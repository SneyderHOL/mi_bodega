FactoryBot.define do
  factory :account do
    sequence(:name) { |n| "account-#{n}" }
    trait :with_free_subscription do
      subscription { create(:free_subscription) }
    end
    trait :with_moderate_subscription do
      subscription { create(:moderate_subscription) }
    end
    trait :with_unlimited_subscription do
      subscription { create(:unlimited_subscription) }
    end
  end
end
