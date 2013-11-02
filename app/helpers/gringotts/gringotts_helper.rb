module Gringotts
  module GringottsHelper
    
    # Overridable by application controller
    # Definse whoever is the owner of the Gringotts vault
    # defaults to current_user for simplicity
    def gringotts_owner
      return current_user
    end
    
    # The before_filter that checks to ensure an authenticated user has been verified
    # Keeps users from accessing pages inbetween authentication and verification
    def gringotts_protego!
      # yes .
    end
        
  end  
end