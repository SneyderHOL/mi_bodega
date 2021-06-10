class AddUniqueConstraintForAccountIdIndexToSubscription < ActiveRecord::Migration[6.1]
  def change
    remove_index :subscriptions, :account_id
    add_index :subscriptions, :account_id, unique: true
  end
end
