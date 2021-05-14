require 'rails_helper'

RSpec.shared_context "sign in as admin user" do
  let(:admin_user_with_unlimited_account) {
    create(:account_user_as_admin_with_unlimited_account)
  }
  before {
    admin_user_with_unlimited_account
    sign_in admin_user_with_unlimited_account.user
    subject
  }
  
end

RSpec.shared_context "sign in as invited user" do
  let(:invited_user_with_unlimited_account) {
    create(:account_user_as_not_admin_with_unlimited_account)
  }
  before {
    invited_user_with_unlimited_account
    sign_in invited_user_with_unlimited_account.user
  }
end
