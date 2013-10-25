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
      return self.codes.last.value
    end
    
    def new_code
      self.codes << Gringotts::Code.create({vault: self})
      return self.recent_code
    end
    
  end
end