require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#validations' do
    let(:item) { build(:item) }
        
    it 'test for new factory object is valid' do
      expect(item).to be_valid
    end

    it 'test that has no empty fields' do
      aggregate_failures do
        item.description = ""
        item.picture = nil
        expect(item).not_to be_valid
        expect(item.errors[:description]).to include("can't be blank")
        expect(item.errors[:picture]).to include("needs to be attached")
      end
    end

    it 'test that import_file has a valid attached picture' do
      aggregate_failures do
        expect(item.picture).to be_attached
        expect(item).to be_valid
      end
    end

    it 'test that check invalid type attached picture' do
      item.picture.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'testing_file.csv')),
                              filename: 'testing_file.csv')
      expect(item).not_to be_valid
    end
  end
end
