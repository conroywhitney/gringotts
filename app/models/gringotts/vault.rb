module Gringotts
  class Vault < ActiveRecord::Base

    belongs_to :user
    validates  :user_id, presence: true, uniqueness: true
    
    has_one    :settings
    has_many   :attempts
    
    def opted_in?
      return self.settings.present?
    end
    
  end
end