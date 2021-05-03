class Account < ApplicationRecord
  attr_accessor :plan

  validates :name, presence: true
  
  has_one :subscription
  has_many :account_users
  has_many :users, through: :account_users
  has_many :boxes
end
