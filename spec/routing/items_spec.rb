require 'rails_helper'

RSpec.describe ItemsController, type: :routing do
  describe "routing" do
    it 'should route to #show' do
      expect(get: 'boxes/1/items/1').to(
        route_to('items#show', box_id: "1", id: "1")
      )
    end

    it 'should route to #new' do
      expect(get: 'boxes/1/items/new').to route_to('items#new', box_id: "1")
    end

    it 'should route to #edit' do
      expect(get: 'boxes/1/items/1/edit').to(
        route_to('items#edit', box_id: "1", id: "1")
      )
    end

    it 'should route to #create' do
      expect(post: 'boxes/1/items').to route_to('items#create', box_id: "1")
    end

    it 'should route to #update' do
      expect(put: 'boxes/1/items/1').to(
        route_to('items#update', box_id: "1", id: "1")
      )
    end

    it 'should route to #update' do
      expect(patch: 'boxes/1/items/1').to(
        route_to('items#update', box_id: "1", id: "1")
      )
    end

    it 'should route to #use_item' do
      expect(post: 'boxes/1/items/1/use_item').to(
        route_to('items#use_item', box_id: "1", id: "1")
      )
    end
  end
end
