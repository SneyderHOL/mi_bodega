require 'rails_helper'

RSpec.describe AccountUser, type: :model do
  describe '#validations' do
    let(:admin_user_with_free_account) {
      build(:account_user_as_admin_with_free_account)
    }
    let(:admin_user_with_moderate_account) {
      build(:account_user_as_admin_with_moderate_account)
    }
    let(:admin_user_with_unlimited_account) {
      build(:account_user_as_admin_with_unlimited_account)
    }
    let(:invited_user_with_free_account) {
      build(:account_user_as_not_admin_with_free_account)
    }
    let(:invited_user_with_moderate_account) {
      build(:account_user_as_not_admin_with_moderate_account)
    }
    let(:invited_user_with_unlimited_account) {
      build(:account_user_as_not_admin_with_unlimited_account)
    }
    
    it 'test that factory objects are valid' do
      aggregate_failures do
        expect(admin_user_with_free_account).to be_valid
        expect(admin_user_with_free_account.).to be_valid
        expect(admin_user_with_moderate_account).to be_valid
        expect(admin_user_with_unlimited_account).to be_valid
        expect(invited_user_with_free_account).to be_valid
        expect(invited_user_with_moderate_account).to be_valid
        expect(invited_user_with_unlimited_account).to be_valid
      end
    end

    it 'test that fields are valid' do
      aggregate_failures do
        admin_user_with_free_account.admin = nil
        admin_user_with_free_account.user = nil
        admin_user_with_free_account.account = nil
        expect(admin_user_with_free_account).not_to be_valid
        expect(admin_user_with_free_account.errors[:admin]).to(
          include("must be true or false")
        )
        expect(admin_user_with_free_account.errors[:user]).to(
          include("must exist")
        )
        expect(admin_user_with_free_account.errors[:account]).to(
          include("must exist")
        )
      end
    end

    it 'test that has no repeated user in same project' do
      aggregate_failures do
        invited_user_with_free_account.save
        new_invited_user_with_free_account = build(
          :account_user_as_not_admin_with_free_account,
          account: invited_user_with_free_account.account,
          user: invited_user_with_free_account.user
        )
        expect(new_invited_user_with_free_account).not_to be_valid
        expect(new_invited_user_with_free_account.errors[:user]).to(
          include("has already been associated")
        )
      end
    end
  end
end
