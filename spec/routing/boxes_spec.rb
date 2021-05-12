require 'rails_helper'

RSpec.describe BoxesController, type: :routing do
  describe "routing" do
    it 'should route to #index' do
      expect(get: 'boxes').to route_to('boxes#index')
    end

    it 'should route to #show' do
      expect(get: 'boxes/1').to route_to('boxes#show', id: '1')
    end

    it 'should route to #new' do
      expect(get: 'boxes/new').to route_to('boxes#new')
    end

    it 'should route to #create' do
      expect(post: 'boxes').to route_to('boxes#create')
    end

    it 'should route to #show_code' do
      expect(get: 'boxes/1/qr_code').to route_to('boxes#show_code', id: '1')
    end
  end
end
