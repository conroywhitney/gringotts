class AddDeliveredAtAndErrorMessageToGringottsDeliveries < ActiveRecord::Migration
  def change
    add_column :gringotts_deliveries, :delivered_at,  :datetime
    add_column :gringotts_deliveries, :error_message, :string
  end
end
