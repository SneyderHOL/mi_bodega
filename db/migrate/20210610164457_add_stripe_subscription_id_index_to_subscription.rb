class AddStripeSubscriptionIdIndexToSubscription < ActiveRecord::Migration[6.1]
  def change
    add_index :subscriptions, :stripe_subscription_id, unique: true
  end
end
