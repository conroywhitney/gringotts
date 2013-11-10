module Gringotts
  class Vault < ActiveRecord::Base

    belongs_to :owner,      polymorphic: true
    validates  :owner_id,   presence: true, uniqueness: true
    validates  :owner_type, presence: true
    
    has_one    :settings
    has_many   :attempts
    has_many   :codes
    has_many   :deliveries
    
    SESSION_FRESHNESS_KEY = :gringotts_expires_at

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
    
    def verified?(session)
      return session[SESSION_FRESHNESS_KEY].present? && session[SESSION_FRESHNESS_KEY] >= Time.now
    end
    
    def verify!(session)
      session[SESSION_FRESHNESS_KEY] = (Time.now + 30.days)
    end
    
    def recent_code
      # generate a new code if there is no previous code!
      # aka, should never have a null code
      return self.codes.last || self.new_code
    end
    
    def new_code
      self.codes << Gringotts::Code.create({vault: self})
      return self.recent_code
    end

    def deliver_new_code!
      code = self.new_code
      # I'm not proud of this but...
      # You have to 'create' here, not 'new'
      # Because delivery uses before_validation callbacks, instead of after_initialize
      # That's a whole 'nother can of worms...
      # ...just FYI
      return Delivery.create(vault: self).deliver!
    end
  
    def phone_number
      return self.settings.present? ? self.settings.phone_number : nil
    end
      
    def should_lock?
      return false unless self.confirmed?
      self.attempts.unsuccessful.since(Time.now - Gringotts::AttemptValidator::LOCKOUT_PERIOD).count  >= Gringotts::AttemptValidator::MAX_UNSUCCESSFUL_ATTEMPTS
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