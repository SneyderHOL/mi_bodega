class AccountUser < ApplicationRecord
  after_initialize :default_values
  belongs_to :account
  belongs_to :user
  validates :admin, presence: true
  
  private

  def default_values
    self.admin ||= false
  end
end
