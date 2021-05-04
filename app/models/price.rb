class Price < ApplicationRecord
  belongs_to :plan
  has_many :subscriptions, dependent: :destroy
  validates :currency, presence: true
  validates :amount, presence: true
  validates :interval, presence: true
  validates :stripe_price_id, presence: true
end
