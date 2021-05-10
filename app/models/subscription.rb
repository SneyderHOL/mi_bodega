class Subscription < ApplicationRecord
  after_initialize :default_values
  acts_as_tenant(:account)
  belongs_to :price
  validates_inclusion_of :active, in: [true, false],
                          message: "must be true or false"
  validates_uniqueness_of :account, message: "has already been associated"
  validates :stripe_subscription_id, presence: true,
            uniqueness: { case_sensitive: false }
  private

  def default_values
    self.active ||= false
  end
end
