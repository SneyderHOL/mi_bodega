class AddCustomerToPayment < ActiveRecord::Migration[6.1]
  def change
    add_column :payments, :stripe_customer_id, :string
  end
end
