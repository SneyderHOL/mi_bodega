class Box < ApplicationRecord
  belongs_to :account
  # acts_as_tenant :account
  belongs_to :user
  validates :name, presence: true
end
