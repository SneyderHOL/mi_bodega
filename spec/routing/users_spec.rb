require 'rails_helper'

RSpec.describe UsersController, type: :routing do
  describe "routing" do
    it 'should route to #new' do
      expect(get: 'add_users').to route_to('users#new')
    end

    it 'should route to #create' do
      expect(post: 'add_users').to route_to('users#create')
    end
  end
end
