class AddStripePriceIdIndexToPrice < ActiveRecord::Migration[6.1]
  def change
    add_index :prices, :stripe_price_id, unique: true
  end
end
