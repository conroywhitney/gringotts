module Gringotts
  class Attempt < ActiveRecord::Base

    belongs_to :vault
    validates  :vault_id,      presence: true
    validates  :code_received, presence: true
    
    after_create :unlock_vault!
    
    def validate(code)
      return self.valid? && AttemptValidator.valid?(self)
    end
    
    def successful?
      return self.successful
    end
    
private

    def unlock_vault!
      if self.successful?
        self.vault.update_attributes(locked_at: nil)
      end
    end
    
  end
end
