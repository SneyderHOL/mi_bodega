require 'rails_helper'

RSpec.describe RegistrationsController, type: :routing do
  describe "routing" do
    it 'should route to #new' do
      expect(get: 'users/sign_up').to route_to('registrations#new')
    end

    it 'should route to #edit' do
      expect(get: 'users/edit').to route_to('registrations#edit')
    end

    it 'should route to #create' do
      expect(post: 'users').to route_to('registrations#create')
    end

    it 'should route to #update' do
      expect(put: 'users').to route_to('registrations#update')
    end
  end
end
