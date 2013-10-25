module Gringotts
  class AttemptValidator
    
    CODE_FRESHNESS_LIMIT = 30.minutes
   
    def self.valid?(attempt)
      return AttemptValidator.new(attempt, attempt.vault.recent_code_object).successful?
    end
    
    def initialize(attempt, code)
      @attempt = attempt
      @code    = code
    end
    
    attr_reader :attempt, :code
    
    def successful?
      if self.stale?
        self.mark_unsuccessful("Code expired")
      elsif self.used?
        self.mark_unsuccessful("Code already used")
      elsif self.matches?
        self.mark_successful
      else
        self.mark_unsuccessful("Invalid code")
      end
      
      return @attempt.successful?
    end
    
    def mark_unsuccessful(msg)
      @attempt.successful = 0
      @attempt.errors[:validator] << msg
    end
    
    def mark_successful
      @attempt.successful = 1
    end
        
    def stale?
      return false
    end
    
    def used?
      return false
    end
    
    def matches?
      return @attempt.code_received == @code.value
    end
    
  end
end