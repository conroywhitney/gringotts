class RemoveUniqueUserIdConstraintOnGringottsAttempts < ActiveRecord::Migration
  def change
    remove_index :gringotts_attempts, :user_id
    add_index    :gringotts_attempts, :user_id, :unique => false
  end
end
