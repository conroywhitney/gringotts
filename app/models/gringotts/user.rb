module Gringotts
  class User < ActiveRecord::Base
    validates_presence_of   :user_id
    validates_uniqueness_of :user_id
    
    validates_presence_of    :phone_number
    validates_uniqueness_of  :phone_number
    validates :phone_number, :phony_plausible => true

    def active?
      return self.active
    end
    
  end
  
end
