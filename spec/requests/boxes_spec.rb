require 'rails_helper'

RSpec.describe BoxesController, type: :request do
  describe "GET /boxes" do
    subject { get boxes_path }

    context 'as an unsigned user' do
      it_behaves_like "access a resource without signed in"
    end

    context 'as a signed up user' do
      include_context "admin user and account chosen"

      it 'should get boxes list' do
        subject
        expect(response).to have_http_status(:ok)
        expect(response.body).to match(/List boxes/i)
      end
    end
  end

  describe "GET /boxes/:id" do
    include_context "admin user and account chosen"

    let(:box) {
      create(:box, account: admin_user_with_unlimited_account.account)
    }

    subject { get box_path(id: box.id) }

    it 'should get the propper box' do
      subject
      expect(response).to have_http_status(:ok)
      expect(response.body).to match(/Show box/i)
    end
  end

  describe "GET /boxes/new" do
    include_context "admin user and account chosen"
    
    subject { get new_box_path }

    it 'should get the new box form' do
      subject
      expect(response).to have_http_status(:ok)
      expect(response.body).to match(/New box/i)
    end
  end
  
  describe "GET /boxes/:id/qr_code" do
    include_context "admin user and account chosen"

    let(:box) {
      create(:box, account: admin_user_with_unlimited_account.account)
    }

    subject { get qr_code_box_path(id: box.id)}

    it 'should get the box qr code' do
      subject
      expect(response).to have_http_status(:ok)
      expect(response.body).to match(/Box's qrcode/i)
    end
  end

  describe "POST /boxes" do
    include_context "admin user and account chosen"
    
    let(:data) {
      {
        params: {
          box: {
            name: "My new box"
          }
        }
      }
    }

    subject { post boxes_path(data) }

    it 'should create new box' do
      expect{ subject }.to change{ Box.count }.by(1)
      expect(response).to have_http_status(:redirect)
      follow_redirect!
      expect(response.body).to match(/My new box/)
    end
  end
end
