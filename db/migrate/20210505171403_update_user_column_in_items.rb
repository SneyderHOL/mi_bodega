class UpdateUserColumnInItems < ActiveRecord::Migration[6.1]
  def change
    change_column_null :items, :user_id, true
  end
end
