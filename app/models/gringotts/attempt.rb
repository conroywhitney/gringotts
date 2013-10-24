module Gringotts
  class Attempt < ActiveRecord::Base

    belongs_to :vault
    validates  :vault_id,      presence: true
    validates  :code_received, presence: true
    
  end
end
