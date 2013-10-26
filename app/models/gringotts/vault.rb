module Gringotts
  class Vault < ActiveRecord::Base

    belongs_to :user
    validates  :user_id, presence: true, uniqueness: true
    
    has_one    :settings
    has_many   :attempts
    has_many   :codes
    
    def opted_in?
      return self.settings.present?
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