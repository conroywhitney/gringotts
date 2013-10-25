module Gringotts
  class AttemptValidator
   
    def self.validate(attempt)
      recent_code = attempt.vault.recent_code
      
      received_code = attempt.code_received
      
      valid = (received_code == recent_code)
      
      if valid
      else
        attempt.errors[:base] << "Invalid code"
      end
      
      return valid
    end
    
  end
end