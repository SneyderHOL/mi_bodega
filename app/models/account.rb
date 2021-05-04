class Account < ApplicationRecord
  attr_accessor :plan

  validates :name, presence: true
  
  has_one :subscription, dependent: :destroy
  has_many :account_users, dependent: :destroy
  has_many :users, through: :account_users
  #has_many :boxes
end
