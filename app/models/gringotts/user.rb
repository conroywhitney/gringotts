module Gringotts
  class User < ActiveRecord::Base
    
    def active?
      return self.active
    end
    
  end
end
