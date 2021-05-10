require 'rails_helper'

RSpec.describe Account, type: :model do
  describe '#validations' do
    let(:account) { build(:account) }
    
    it 'test that factory object is valid' do
      expect(account).to be_valid
    end

    it 'test that factory name sequence is valid' do
      account.save
      second_account = build(:account)
      expect(second_account).to be_valid
    end

    it 'test that has name uniqueness validation' do
      aggregate_failures do
        account.save
        second_account = build(:account)
        second_account.name = account.name
        expect(second_account).not_to be_valid
        expect(second_account.errors[:name]).to include("has already been taken")

        second_account.name = account.name.downcase
        expect(second_account).not_to be_valid
        expect(second_account.errors[:name]).to include("has already been taken")

        second_account.name = account.name.upcase
        expect(second_account).not_to be_valid
        expect(second_account.errors[:name]).to include("has already been taken")
      end
    end

    it 'test that has no name' do
      aggregate_failures do
        account.name = ''
        expect(account).not_to be_valid
        expect(account.errors[:name]).to include("can't be blank")
      end
    end

    it 'test that has name length withing 95 characters' do
      aggregate_failures do
        account.name = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\
                        aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
        expect(account).not_to be_valid
        expect(account.errors[:name]).to include("is too long (maximum is 95 characters)")
      end
    end
  end
end
