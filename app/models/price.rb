class Price < ApplicationRecord
  belongs_to :plan
  has_many :subscriptions, dependent: :destroy
  validates :currency, presence: true
  validates :amount, presence: true
  validates :interval, presence: true
  validates_uniqueness_of :plan, message: "has already been associated"
  validates :stripe_price_id, presence: true,
            uniqueness: { case_sensitive: false }
end
