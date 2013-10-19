module Gringotts
  class User < ActiveRecord::Base
    validates_presence_of :phone_number, if: :active?
    validates :phone_number, :phony_plausible => true, if: :active?
    
    def active?
      return self.active
    end
    
  end
  
end
