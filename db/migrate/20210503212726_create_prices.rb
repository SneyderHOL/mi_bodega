class CreatePrices < ActiveRecord::Migration[6.1]
  def change
    create_table :prices do |t|
      t.string :currency
      t.integer :amount
      t.string :interval
      t.string :stripe_price_id
      t.references :plan, null: false, foreign_key: true

      t.timestamps
    end
  end
end
