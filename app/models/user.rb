class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :account_users
  has_many :accounts, through: :account_users
  has_many :boxes
  has_one :payment
  accepts_nested_attributes_for :payment

  def add_account(account, admin = false)
    added_account = AccountUser.create(user: self, account: account, admin: admin)
  end
end
