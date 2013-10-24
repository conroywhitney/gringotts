module Gringotts
  class Attempt < ActiveRecord::Base
    
    belongs_to  :user, :class_name => 'Gringotts::User'
    validates   :user_id, presence: true
    
  end
end
