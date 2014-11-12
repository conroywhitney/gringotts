module Gringotts
  module GringottsHelper
    
    COOKIE_KEY = "gringotts_recognized"
    
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
    
    def gringotts_recognized?
      cookie_hash = JSON.parse(cookies.signed[COOKIE_KEY], {:symbolize_names => true}) unless cookies[COOKIE_KEY].nil?
      if cookie_hash.nil? || gringotts_owner.nil?
        false
      else
        (cookie_hash[:user_id] == gringotts_owner.id) && (Time.parse(cookie_hash[:valid_until]) > Time.now)
      end
    end
    
    def gringotts_recognize!
      cookie_hash = {user_id: gringotts_owner.id, valid_until: 30.days.from_now}
      cookies.signed[COOKIE_KEY] = {value: cookie_hash.to_json, expires: 30.days.from_now}
    end
    
    def gringotts_protego?
              # config/gringotts.yml can disable Gringotts entirely
      return  Gringotts::Config.enabled &&
              # fine-grain control over ignoring certain paths, like a .gitignore
              !(Gringotts::Config.ignore_paths && Gringotts::Config.ignore_paths.include?(request.original_fullpath)) &&
              # if the object designated as the "owner" of this Gringotts vault is defined
              # then we need to make sure that they are verified on every single page load
              # otherwise, the user could simply navigate away from the verify page
              gringotts_owner.present?
    end
    
    # The before_filter that checks to ensure an authenticated user has been verified
    # Keeps users from accessing pages inbetween authentication and verification
    def gringotts_protego!
      # check to see if we should be protecting in the first place
      # maybe not, depending on config/gringotts.yml and user status
      if gringotts_protego?
        # find or create a vault for this owner
        @gringotts = Gringotts::Vault.for_owner(gringotts_owner)
        
        # what we do now is based on what the user has done before in the past...
        
        if @gringotts.show_prompt?
          # 1) owner is a first-timer, and not know about this 2FA -- show prompt
          gringotts_redirect_to gringotts_engine.prompt_path
        elsif @gringotts.confirmed?
          # 2) owner has opted-in -- require verification
          if @gringotts.verified?(session) || gringotts_recognized?
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