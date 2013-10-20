module Gringotts
  class Settings < ActiveRecord::Base

    validates_presence_of   :user_id
    validates_uniqueness_of :user_id
    
    validates_presence_of    :phone_number
    validates_uniqueness_of  :phone_number
    validates :phone_number, :phony_plausible => true
    
  end
  
end
