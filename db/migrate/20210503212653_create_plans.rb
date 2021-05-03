class CreatePlans < ActiveRecord::Migration[6.1]
  def change
    create_table :plans do |t|
      t.string :name
      t.integer :box_limit
      t.string :stripe_product_id

      t.timestamps
    end
  end
end
