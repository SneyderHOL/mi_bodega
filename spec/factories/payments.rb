FactoryBot.define do
  factory :payment do
    sequence(:token) { |n| "TPKySqmfgx98l1a5tri#{n}ng" }
    user { create(:user) }
  end
end
