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
    include_context "sign in as admin user"

    let(:account_id) { admin_user_with_unlimited_account.account.id.to_s }
    
    subject { put account_path(id: account_id) }

    it 'should redirect to home' do
      expect(subject).to redirect_to(root_path)

    end

    it 'should have a current account' do
      subject
      get accounts_path
      expect(response.body).to match(/current account/i)
    end
  end
end
