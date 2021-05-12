require 'rails_helper'

RSpec.describe HomeController, type: :routing do
  describe "routing" do
    it 'should route to #index' do
      expect(get: '/').to route_to('home#index')
    end
  end
end
