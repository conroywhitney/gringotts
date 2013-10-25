module Gringotts
  class AttemptValidator
   
    def self.validate(attempt)
      if (attempt.code_received == attempt.vault.recent_code)
        attempt.successful = 1
      else
        attempt.successful = 0
        attempt.errors[:base] << "Invalid code"
      end
      
      return attempt.successful?
    end
    
  end
end