class Plan < ApplicationRecord
  has_one :price, dependent: :destroy
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :box_limit, presence: true
  validates :stripe_product_id, presence: true,
            uniqueness: { case_sensitive: false }

  def self.options
    Plan.all.map { |plan| [plan.name.capitalize, plan.id] }
  end

  def self.upgrade_plan(exception = 'Free')
    plans = []
    Plan.all.each do |plan|
      if plan.name.downcase != exception.downcase
        plans.push([plan.name.capitalize, plan.id])
      end
    end
    plans
  end
end
