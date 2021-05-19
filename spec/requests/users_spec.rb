require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe 'GET /add_users' do
    subject { get add_new_user_path }

    context 'with permissions' do
      include_context "admin user and account chosen"

      it 'should get add_user form' do
        subject
        expect(response).to have_http_status(:ok)
        expect(response.body).to match(/Add user/i)
      end
    end

    context 'without permissions' do
      include_context "invited user and account chosen"

      it 'should redirect to home' do
        expect(subject).to redirect_to(root_path)
      end
    end

    context 'as an unsigned user' do
      it_behaves_like "access a resource without signed in"
    end
  end
end
