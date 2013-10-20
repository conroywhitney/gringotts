class AddIndexOnUserIdToGingottsUsers < ActiveRecord::Migration
  def change
    add_index :gringotts_users, :user_id, :unique => true
  end
end
