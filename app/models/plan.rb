class Plan < ApplicationRecord
  has_one :price
  validates :name, presence: true
  validates :box_limit, presence: true
  validates :stripe_product_id, presence: true

  def self.options
    Plan.all.map { |plan| [plan.name.capitalize, plan.id] }
  end
end
