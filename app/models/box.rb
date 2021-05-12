class Box < ApplicationRecord
  acts_as_tenant(:account)
  has_many :items
  validates :name, presence: true, length: { maximum: 95 }
  validate :name_uniqueness_within_same_account
  validate :limit_boxes_according_to_plan

  def limit_boxes_according_to_plan
    if self.account.subscription
      limit = self.account.subscription.price.plan.box_limit
      if limit > 0 && self.new_record? && (self.account.boxes.count >= limit)
        errors.add(:base, "Your account cannot have more boxes than #{limit}")
      end
    else
      errors.add(:base, "Your account cannot create boxes")
    end
  end

  def name_uniqueness_within_same_account
    if self.new_record? && self.account.boxes.where('lower(name) = ?', name.downcase).first
      errors.add(:name, "has already been taken")
    end
  end
end
