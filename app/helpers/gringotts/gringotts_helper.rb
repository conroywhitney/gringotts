module Gringotts
  module GringottsHelper
    
    # Overridable by application controller
    # Definse whoever is the owner of the Gringotts vault
    # defaults to current_user for simplicity
    def gringotts_owner
      return current_user
    end
    
    # used to redirect back after verifying
    def gringotts_next_url
      return flash[:gringotts_next_url]  
    end
    
    # helper method for seamlessly redirecting within app
    # ensures we put users back in the same place when we're done with them
    def gringotts_redirect_to(url)
      # save url for redirecting back after we verify
      flash[:gringotts_next_url] = request.original_url
      
      # keep other flash items (e.g., success messages)
      flash.keep
      
      # last but not least ... redirect
      redirect_to url
    end
    
    # The before_filter that checks to ensure an authenticated user has been verified
    # Keeps users from accessing pages inbetween authentication and verification
    def gringotts_protego!
      # if the object designated as the "owner" of this Gringotts vault is defined
      # then we need to make sure that they are verified on every single page load
      # otherwise, the user could simply navigate away from the verify page
      if gringotts_owner.present?
        # find or create a vault for this owner
        @gringotts = Gringotts::Vault.for_owner(gringotts_owner)
        
        # what we do now is based on what the user has done before in the past...
        
        if @gringotts.show_prompt?
          # 1) owner is a first-timer, and not know about this 2FA -- show prompt
          gringotts_redirect_to gringotts_engine.prompt_path
        elsif @gringotts.opted_in?
          # 2) owner has opted-in -- require verification
          if @gringotts.verified?
            # already verified -- do not do anything
          else
            # make them verify
            gringotts_redirect_to gringotts_engine.verification_path
          end
        else
          # 3) owner has declined 2FA -- not do anything
        end
      else
        # if owner not currently defined, assume is an anonymous situation
        # therefore, no need to bother them
      end
    end
        
  end  
end