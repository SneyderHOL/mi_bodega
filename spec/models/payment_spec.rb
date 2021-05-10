require 'rails_helper'

RSpec.describe Payment, type: :model do
  describe '#validations' do
    let(:payment) { build(:payment) }
    
    it 'test that factory object is valid' do
      expect(payment).to be_valid
    end

    it 'test that factory sequence is valid' do
      payment.save
      second_payment = build(:payment)
      expect(second_payment).to be_valid
    end

    it 'test for uniquenes' do
      aggregate_failures do
        payment.save
        second_payment = build(:payment, token: payment.token, user: payment.user)
        expect(second_payment).not_to be_valid
        expect(second_payment.errors[:token]).to include("has already been taken")
        expect(second_payment.errors[:user]).to include("has already been associated")
      end
    end

    it 'test that has no empty fields' do
      aggregate_failures do
        payment.user = nil
        payment.token = ""
        expect(payment).not_to be_valid
        expect(payment.errors[:token]).to include("can't be blank")
        expect(payment.errors[:user]).to include("must exist")
      end
    end
  end
end
