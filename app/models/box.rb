class Box < ApplicationRecord
  acts_as_tenant(:account)
  validates :name, presence: true
end
