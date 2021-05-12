require 'rails_helper'

RSpec.describe AccountsController, type: :routing do
  describe "routing" do
    it 'should route to #index' do
      expect(get: 'accounts').to route_to('accounts#index')
    end

    it 'should route to #update' do
      expect(put: 'accounts/1').to route_to('accounts#update', id: '1')
    end
  end
end
