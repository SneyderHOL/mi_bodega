require 'rails_helper'

RSpec.describe 'Devise session', type: :routing do
  describe "routing" do
    it 'should route to devise/sessions#new' do
      expect(get: 'users/sign_in').to route_to('devise/sessions#new')
    end

    it 'should route to devise/sessions#create' do
      expect(post: 'users/sign_in').to route_to('devise/sessions#create')
    end

    it 'should route to devise/sessions#destroy' do
      expect(delete: 'users/sign_out').to route_to('devise/sessions#destroy')
    end
  end
end
