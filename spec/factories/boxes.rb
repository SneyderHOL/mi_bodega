FactoryBot.define do
  factory :box do
    sequence(:name) { |n| "MyBox-#{n}" }
    qr_code { "qrcode" }
    factory :box_within_free_account do
      account { create(:account, :with_free_subscription) }
    end
    factory :box_within_moderate_account do
      account { create(:account, :with_moderate_subscription) }
    end
    factory :box_within_unlimited_account do
      account { create(:account, :with_unlimited_subscription) }
    end
  end
end
