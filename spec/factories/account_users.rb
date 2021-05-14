FactoryBot.define do
  factory :account_user do
    factory :account_user_as_admin_with_free_account do
      admin { true }
      account { create(:account, :with_free_subscription) }
      user { 
        admin_user = create(:user)
        create(:payment, user: admin_user)
        admin_user
      }
    end
    factory :account_user_as_admin_with_moderate_account do
      admin { true }
      account { create(:account, :with_moderate_subscription) }
      user { 
        admin_user = create(:user)
        create(:payment, user: admin_user)
        admin_user
      }
    end
    factory :account_user_as_admin_with_unlimited_account do
      admin { true }
      account { create(:account, :with_unlimited_subscription) }
      user { 
        admin_user = create(:user)
        create(:payment, user: admin_user)
        admin_user
      }
    end
    factory :account_user_as_not_admin_with_free_account do
      admin { true }
      account { create(:account, :with_free_subscription) }
      user { create(:user) }
    end
    factory :account_user_as_not_admin_with_moderate_account do
      admin { true }
      account { create(:account, :with_moderate_subscription) }
      user { create(:user) }
    end
    factory :account_user_as_not_admin_with_unlimited_account do
      admin { true }
      account { create(:account, :with_unlimited_subscription) }
      user { create(:user) }
    end
  end
end
