require 'phony_rails'

module Gringotts
  class Settings < ActiveRecord::Base
    
    belongs_to :vault
    validates  :vault_id,     presence: true, uniqueness: true
    validates  :phone_number, presence: true, uniqueness: true, phony_plausible: true
    
  end
  
end
