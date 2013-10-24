module Gringotts
  class Settings < ActiveRecord::Base
    
    validates :user_id, presence: true, uniqueness: true
    validates :phone_number, presence: true, uniqueness: true, phony_plausible: true
    
  end
  
end
