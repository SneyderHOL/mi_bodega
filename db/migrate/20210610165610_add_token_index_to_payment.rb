class AddTokenIndexToPayment < ActiveRecord::Migration[6.1]
  def change
    add_index :payments, :token, unique: true
  end
end
