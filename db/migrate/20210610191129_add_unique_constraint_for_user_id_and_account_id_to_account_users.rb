class AddUniqueConstraintForUserIdAndAccountIdToAccountUsers < ActiveRecord::Migration[6.1]
  def change
    add_index :account_users, [:user_id, :account_id], unique: true
  end
end
