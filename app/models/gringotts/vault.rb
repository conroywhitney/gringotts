module Gringotts
  class Vault < ActiveRecord::Base

    belongs_to :owner,      polymorphic: true
    validates  :owner_id,   presence: true, uniqueness: true
    validates  :owner_type, presence: true
    
    has_one    :settings
    has_many   :attempts
    has_many   :codes

    def self.for_owner(obj)
      return Gringotts::Vault.where(owner_id: obj.id, owner_type: obj.class.name).first_or_create
    end

    def signed_up?
      return self.settings.present? && self.settings.phone_number.present?
    end
      
    def opted_in?
      return self.signed_up? && self.confirmed?
    end
      
    def show_prompt?
      return self.prompt_seen_at.nil?
    end
          
    def prompt_shown!
      self.update_attributes!(prompt_seen_at: Time.now)
    end
      
    def confirmed?
      self.confirmed_at.present?
    end
    
    def confirm!
      self.update_attributes!(confirmed_at: Time.now) unless self.confirmed?
    end
    
    def verified?
      return false
    end
    
    def verify!
      # save something in the session... or something...
    end
      
    def recent_code
      return self.recent_code_object.value
    end
    
    def recent_code_object
      return self.codes.last
    end
    
    def new_code
      self.codes << Gringotts::Code.create({vault: self})
      return self.recent_code
    end
    
    def lock!
      self.update_attributes(locked_at: Time.now)
    end
    
    def locked?
      return self.locked_at.present? && self.locked_at > Gringotts::AttemptValidator::LOCKOUT_PERIOD.ago
    end
    
    def unlock!
      self.update_attributes(locked_at: nil)
    end
    
  end
end