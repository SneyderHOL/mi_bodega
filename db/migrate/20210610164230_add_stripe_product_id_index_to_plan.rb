class AddStripeProductIdIndexToPlan < ActiveRecord::Migration[6.1]
  def change
    add_index :plans, :stripe_product_id, unique: true
  end
end
