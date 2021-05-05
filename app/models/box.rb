class Box < ApplicationRecord
  acts_as_tenant(:account)
  has_many :items
  validates :name, presence: true
  validate :limit_boxes_according_to_plan

  def limit_boxes_according_to_plan
    limit = self.account.subscription.price.plan.box_limit
    if limit > 0 && self.new_record? && (self.account.boxes.count == limit)
      errors.add(:base, "Your account cannot have more boxes than #{limit}")
    end
  end
end
