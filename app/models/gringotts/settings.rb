module Gringotts
  class Settings < ActiveRecord::Base
    
    belongs_to :user, :class_name => 'Gringotts::User'

    validates_presence_of   :user_id
    validates_uniqueness_of :user_id
    
    validates_presence_of    :phone_number
    validates_uniqueness_of  :phone_number
    validates :phone_number, :phony_plausible => true
    
  end
  
end
