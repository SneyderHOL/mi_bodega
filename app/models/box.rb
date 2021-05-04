class Box < ApplicationRecord
  acts_as_tenant(:account)
  # belongs_to :account
  belongs_to :user
  validates :name, presence: true
end
