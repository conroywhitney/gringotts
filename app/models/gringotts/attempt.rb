module Gringotts
  class Attempt < ActiveRecord::Base

    belongs_to :vault
    validates  :vault_id,      presence: true
    validates  :code_received, presence: true
    
    scope :unsuccessful, lambda { where(successful: false) }
    scope :since,        lambda { |dt| where("created_at > ?", dt) } 
    
    def validate(code)
      return self.valid? && AttemptValidator.valid?(self)
    end
    
    def successful?
      return self.successful
    end
        
  end
end
