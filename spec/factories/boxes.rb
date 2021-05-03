FactoryBot.define do
  factory :box do
    name { "MyString" }
    qr_code { "MyString" }
    account { nil }
    user { nil }
  end
end
