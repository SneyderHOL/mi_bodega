require 'rails_helper'

RSpec.describe 'Devise session', type: :request do
  describe "GET users/sign_in" do
    it 'should returns a success response' do
      get new_user_session_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST users/sign_in" do
    let(:data) {
      {
        params: {
          user: {
            email: "testing_user@example.com",
            password: "123456"
          }
        }
      }
    }

    before { create(:user, email: "testing_user@example.com", password: "123456") }

    subject { post user_session_path(data) }

    context 'when login as registered user' do
      it 'should redirect to accounts' do
        expect(subject).to redirect_to(accounts_path)
      end
    end

    context 'when login as unregistered user' do
      it 'should render to sign_in form' do
        data[:params][:user][:email] = "new_user_for_login@example.com"
        subject
        expect(response).to have_http_status(:success)
        expect(response.body).to match(/Invalid Email or password/i)
        expect(response.body).to match(/Log In/i)
      end
    end
  end

  describe "DELETE users/sign_OUT" do
    include_context "sign in as admin user"
    context 'as a signed in user' do
      it 'should sign out' do
        expect(delete destroy_user_session_path).to redirect_to(root_path)
      end
    end
  end
end
