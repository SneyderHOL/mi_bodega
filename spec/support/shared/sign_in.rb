require 'rails_helper'

RSpec.shared_context "sign in as admin user" do
  let(:admin_user_with_unlimited_account) {
    create(:account_user_as_admin_with_unlimited_account)
  }
  before {
    admin_user_with_unlimited_account
    sign_in admin_user_with_unlimited_account.user
  }
  
end

RSpec.shared_context "admin user and account chosen" do
  let(:admin_user_with_unlimited_account) {
    create(:account_user_as_admin_with_unlimited_account)
  }
  before {
    admin_user_with_unlimited_account
    sign_in admin_user_with_unlimited_account.user
    put account_path(id: admin_user_with_unlimited_account.account_id.to_s)
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

RSpec.shared_context "invited user and account chosen" do
  let(:invited_user_with_unlimited_account) {
    create(:account_user_as_not_admin_with_unlimited_account)
  }
  before {
    invited_user_with_unlimited_account
    sign_in invited_user_with_unlimited_account.user
    put account_path(id: invited_user_with_unlimited_account.account_id.to_s)
  }
end
