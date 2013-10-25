class AddExpiresAtToGringottsCodes < ActiveRecord::Migration
  def change
    add_column :gringotts_codes, :expires_at, :datetime
  end
end
