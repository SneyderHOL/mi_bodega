require 'rails_helper'

RSpec.describe ItemsController, type: :request do

  shared_context 'log in admin user with some boxes' do
    include_context "admin user and account chosen"

    let(:box1) {
      create(:box, account: admin_user_with_unlimited_account.account)
    }

    let(:box2) {
      create(:box, account: admin_user_with_unlimited_account.account)
    }
  end

  describe "GET /boxes/:box_id/items/:id" do
    include_context 'log in admin user with some boxes'

    let(:item) { create(:item, box: box1) }

    subject { get box_item_path(box_id: box1.id, id: item.id) }

    it 'should display item' do
      subject
      expect(response).to have_http_status(:ok)
      expect(response.body).to match(/Show item/i)
    end
  end

  describe "GET /boxes/:box_id/items/new" do
    include_context 'log in admin user with some boxes'
    
    subject { get new_box_item_path(box_id: box1.id) }

    it 'should get the new item form' do
      subject
      expect(response).to have_http_status(:ok)
      expect(response.body).to match(/Create a new item/i)
    end
  end

  describe "GET /boxes/:box_id/items/:id/edit" do
    include_context 'log in admin user with some boxes'

    let(:item) { create(:item, box: box1) }

    subject { get edit_box_item_path(box_id: box1.id, id: item.id) }

    it 'should display move item form' do
      subject
      expect(response).to have_http_status(:ok)
      expect(response.body).to match(/Move item/i)
    end
  end

  describe "POST /boxes/:box_id/items/" do
    include_context 'log in admin user with some boxes'

    let(:data) {
      {
        item: {
          description: "My new item",
          picture: fixture_file_upload('testing_picture.png', 'image/png'),
          box_id: box1.id
        }
      }
    }

    subject { post box_items_path(box_id: box1.id), params: data }

    it 'should create item' do
      expect{ subject }.to change{ Item.count }.by(1)
      expect(response).to have_http_status(:redirect)
      follow_redirect!
      expect(response.body).to match(/Item was created successfully/i)
    end
  end

  describe "PUT /boxes/:box_id/items/:id" do
    include_context 'log in admin user with some boxes'

    let(:item) { create(:item, box: box1) }

    let(:data) {
      {
        item: {
          new_box: box2.id
        }
      }
    }

    subject { put box_item_path(box_id: box1.id, id: item.id), params: data }

    it 'should move item to another box' do
      subject
      expect(response).to have_http_status(:redirect)
      follow_redirect!
      expect(response.body).to include("#{box2.name}")
      expect(response.body).to include("#{item.description}")
      expect(box2.items.first).to eq(item)
    end
  end

  describe "POST /boxes/:box_id/items/:id/use_item" do
    include_context 'log in admin user with some boxes'

    let(:item) { create(:item, box: box1) }

    subject { post use_item_box_item_path(box_id: box1.id, id: item.id) }

    it 'should have "in_use state"' do
      expect(subject).to(
        redirect_to(box_item_path(box_id: box1.id, id: item.id))
      )
      follow_redirect!
      expect(response.body).to match(/You are currently using this item/i)
    end
  end
end
