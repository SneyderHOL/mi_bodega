require 'rails_helper'

RSpec.describe Box, type: :model do
  shared_examples_for "box limit object creation" do
    it 'last element should not be valid' do
      aggregate_failures do
        limit = subject.subscription.price.plan.box_limit
        i = 0;
        loop do
          if i >= limit
            break
          end
          new_free_box = create(:box, account: subject)
          i += 1
        end
        last_box = build(:box, account: subject)
        expect(last_box).not_to be_valid
        expect(last_box.errors[:base]).to include("Your account cannot have more boxes than #{limit}")
      end
    end
  end

  describe '#validations' do
    let(:free_box) { build(:box_within_free_account) }
    let(:moderate_box) { build(:box_within_moderate_account) }
    let(:unlimited_box) { build(:box_within_unlimited_account) }
    
    it 'test for new object' do
      expect(free_box).to be_valid
      expect(moderate_box).to be_valid
      expect(unlimited_box).to be_valid
    end

    context 'no object within an account with inactive/without subscription' do
      it 'should not be valid' do
        aggregate_failures do
          account = create(:account)
          new_box = build(:box, account: account)
          expect(new_box).not_to be_valid
          expect(new_box.errors[:base]).to(
            include("Your account cannot create boxes")
        )
        end
      end
    end

    it 'test for sequence in factory object' do
      moderate_box.save
      second_moderate_box = build(:box, account: moderate_box.account)
      expect(second_moderate_box).to be_valid
      unlimited_box.save
      second_unlimited_box = build(:box, account: unlimited_box.account)
      expect(second_unlimited_box).to be_valid
    end

    it 'test for name uniquenes in the same account' do
      aggregate_failures do
        moderate_box.save
        second_moderate_box = build(
          :box,
          name: moderate_box.name,
          account: moderate_box.account
        )
        expect(second_moderate_box).not_to be_valid
        expect(second_moderate_box.errors[:name]).to(
          include("has already been taken")
        )
      end
    end

    it 'test that has name length withing 95 characters' do
      aggregate_failures do
        moderate_box.name = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\
                            aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
        expect(moderate_box).not_to be_valid
        expect(moderate_box.errors[:name]).to(
          include("is too long (maximum is 95 characters)")
        )
      end
    end

    context 'test for box creation limit restriction' do
      subject { account = create(:account, :with_free_subscription) }
      it_behaves_like 'box limit object creation'

      subject { account = create(:account, :with_moderate_subscription) }
      it_behaves_like 'box limit object creation'
    end

    it 'test for unlimited box creation' do
      aggregate_failures do
        account = create(:account, :with_unlimited_subscription)
        # testing limit up to 100
        limit = 100
        i = 0;
        loop do
          if i >= limit
            break
          end
          new_box = create(:box, account: account)
          i += 1
        end
        last_box = build(:box, account: account)
        expect(last_box).to be_valid
      end
    end
  end
end
