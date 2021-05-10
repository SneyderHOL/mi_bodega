class AccountUser < ApplicationRecord
  after_initialize :default_values
  belongs_to :account
  belongs_to :user
  validates_inclusion_of :admin, in: [true, false],
                          message: "must be true or false"
  validates_uniqueness_of :user, :scope => :account,
                          message: "has already been associated"
  
  private

  def default_values
    self.admin ||= false
  end
end
