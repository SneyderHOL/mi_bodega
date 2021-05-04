class RemoveUserFromBox < ActiveRecord::Migration[6.1]
  def change
    remove_reference :boxes, :user, null: false, foreign_key: true
  end
end
