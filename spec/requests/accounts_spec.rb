require 'rails_helper'

RSpec.describe AccountsController, type: :request do
  describe "GET /accounts" do
    subject { get accounts_path }

    context 'as a signed up user' do
      include_context "sign in as admin user"

      before { subject }

      it 'should get accounts list' do
        expect(response).to have_http_status(:ok)
        expect(response.body).to match(/Select an account/i)
      end
    end

    context 'as an unsigned user' do
      it_behaves_like "access a resource without signed in"
    end
  end

  describe "PUT /accounts/id" do
    # Create account_user relation
    let(:admin_user_with_unlimited_account) {
      create(:account_user_as_admin_with_unlimited_account)
    }

    it 'should redirect to home' do
      sign_in admin_user_with_unlimited_account.user

      # Account related to user
      account_id = admin_user_with_unlimited_account.account.id.to_s
      
      expect(put account_path(id: account_id)).to redirect_to(root_path)
    end
  end
end
