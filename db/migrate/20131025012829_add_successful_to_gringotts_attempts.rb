class AddSuccessfulToGringottsAttempts < ActiveRecord::Migration
  def change
    add_column :gringotts_attempts, :successful, :boolean, null: false, default: 0
  end
end
