module Gringotts
  class AttemptValidator
   
    def self.validate(attempt)
      puts "*"*50
      
      recent_code = attempt.vault.recent_code
      puts "Recent Code [#{recent_code}]"
      
      received_code = attempt.code_received
      puts "Received Code [#{received_code}]"
      
      valid = (received_code == recent_code)
      puts "Valid? [#{valid}]"
      
      if valid
        puts "Since valid, no errors!"
      else
        puts "Since not valid, errors!!"
        attempt.errors[:base] << "Invalid code"
        puts "attempt [#{attempt.inspect}]"
      end
      
      puts "*"*50
      return valid
    end
    
  end
end