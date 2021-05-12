FactoryBot.define do
  factory :item do
    description { "MyDescription" }
    box { create(:box_within_free_account) }
    user { nil }
    after (:build) do |item|
      item.picture.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'testing_picture.png')),
                              filename: 'testing_picture.png', content_type: 'image/png')
    end
  end
end
