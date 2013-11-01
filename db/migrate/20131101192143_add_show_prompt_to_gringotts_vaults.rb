class AddShowPromptToGringottsVaults < ActiveRecord::Migration
  def change
    add_column :gringotts_vaults, :prompt_seen_at, :datetime, null: true
  end
end
