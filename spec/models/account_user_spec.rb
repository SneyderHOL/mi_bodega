require 'rails_helper'

RSpec.describe AccountUser, type: :model do
  describe '#validations' do
    let(:new_account_user) { build(:account_user) }
    
    it 'test that fields are valid' do
      aggregate_failures do
        new_account_user.admin = nil
        expect(new_account_user).not_to be_valid
        expect(new_account_user.errors[:admin]).to include("must be true or false")
        expect(new_account_user.errors[:user]).to include("must exist")
        expect(new_account_user.errors[:account]).to include("must exist")
      end
    end

    it 'test that has no repeated user in same project' do
      aggregate_failures do
        user = create(:user)
        account = create(:account)
        old_account_user = build(:account_user)
        old_account_user.user = user
        old_account_user.account = account
        old_account_user.save
        new_account_user.account = account
        new_account_user.user = user
        expect(new_account_user).not_to be_valid
        expect(new_account_user.errors[:user]).to include("has already been associated")
      end
    end
  end
end
