module Gringotts
  class Attempt < ActiveRecord::Base

    belongs_to :vault
    validates  :vault_id,      presence: true
    validates  :code_received, presence: true
    
    after_create :lock_vault?
    after_create :unlock_vault!
    
    scope :unsuccessful, lambda { where(successful: false) }
    scope :since,        lambda { |dt| where("created_at > ?", dt) } 
    
    def validate(code)
      return self.valid? && AttemptValidator.valid?(self)
    end
    
    def successful?
      return self.successful
    end
    
private

    def lock_vault?
      unless self.successful?
        if self.vault.present? &&
           self.vault.attempts.unsuccessful.since(Time.now - Gringotts::AttemptValidator::LOCKOUT_PERIOD).count  >= Gringotts::AttemptValidator::MAX_UNSUCCESSFUL_ATTEMPTS
            self.vault.lock!
        end
      end
    end
    
    def unlock_vault!
      if self.successful?
        self.vault.update_attributes(locked_at: nil)
      end
    end
    
  end
end
