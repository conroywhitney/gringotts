module Gringotts
  class User < ActiveRecord::Base
    validates_presence_of :user_id
    validates_uniqueness_of :user_id
    
    validates_presence_of :phone_number, if: :active?
    validates :phone_number, :phony_plausible => true, if: :active?
    validates_uniqueness_of :phone_number
    
    def active?
      return self.active
    end
    
  end
  
end
