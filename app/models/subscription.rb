class Subscription < ApplicationRecord
  after_initialize :default_values
  acts_as_tenant(:account)
  belongs_to :price
  
  private

  def default_values
    self.active ||= false
  end
end
