require 'rails_helper'

RSpec.describe HomeController, type: :request do
  shared_examples_for 'home page for user' do
    it 'should display welcome user.email message' do
      expect(response.body).to match(/Welcome: [\w+\-.]+@[a-z\d\-.]+\.[a-z]+/)
    end

    it 'should not have a sign up option' do
      expect(response.body).not_to include("Sign Up")
    end

    it 'should not have a sign in option' do
      expect(response.body).not_to include("Sign In")
    end

    it 'should have a log out option' do
      expect(response.body).to include("Log Out")
    end
  end
  describe "GET /" do
    subject { get '/' }
    
    it 'should returns a success response' do
      subject
      expect(response).to have_http_status(:ok)
    end
    
    describe 'as an unregistered user' do
      context 'check elements in response' do
        before { subject }

        it 'should display welcome to app message' do
          expect(response.body).to include("Welcome to Mi Bodega App!")
        end

        it 'should display several plans' do
          aggregate_failures do
            expect(response.body).to include("Free Plan")
            expect(response.body).to include("Moderate Plan")
            expect(response.body).to include("Unlimited Plan")
          end
        end

        it 'should have a sign up option' do
          expect(response.body).to include("Sign Up")
        end

        it 'should have a sign in option' do
          expect(response.body).to include("Sign In")
        end
      end
    end

    describe 'as a registered user' do
      include_context "sign in as admin user"
      it_behaves_like 'home page for user'
      include_context "sign in as invited user"
      it_behaves_like 'home page for user'
    end
  end
end
