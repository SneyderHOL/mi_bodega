require 'rails_helper'

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
