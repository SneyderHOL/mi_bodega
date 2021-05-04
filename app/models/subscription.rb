class Subscription < ApplicationRecord
  after_initialize :default_values
  acts_as_tenant(:account)
  # belongs_to :account
  belongs_to :price
  validates :active, presence: true
  
  private

  def default_values
    self.active ||= false
  end
end
