class AddPhoneNumberToGringottsUsers < ActiveRecord::Migration
  def change
    add_column :gringotts_users, :phone_number, :string
  end
end
