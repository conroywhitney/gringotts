require 'phony_rails'

module Gringotts
  class Settings < ActiveRecord::Base
    
    belongs_to :vault
    validates  :vault_id,     presence: true, uniqueness: true
    phony_normalize :phone_number, :default_country_code => 'US'
    validates  :phone_number, presence: true, uniqueness: true, phony_plausible: true
    
    after_update :unconfirm!, :if => :phone_number_changed?
    
    def unconfirm!
      self.vault.unconfirm!
    end
    
  end
  
end
