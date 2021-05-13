require 'rails_helper'

RSpec.describe BillingPortalController, type: :routing do
  describe "routing" do
    it 'should route to #new' do
      expect(get: 'billing_portal').to route_to('billing_portal#new')
    end
  end
end
