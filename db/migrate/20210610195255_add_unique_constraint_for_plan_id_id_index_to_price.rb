class AddUniqueConstraintForPlanIdIdIndexToPrice < ActiveRecord::Migration[6.1]
  def change
    remove_index :prices, :plan_id
    add_index :prices, :plan_id, unique: true
  end
end
