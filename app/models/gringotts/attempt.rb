module Gringotts
  class Attempt < ActiveRecord::Base

    validates :user_id, presence: true
    validates :code_received, presence: true
    
  end
end
