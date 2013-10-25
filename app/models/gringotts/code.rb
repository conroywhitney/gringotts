module Gringotts
  class Code < ActiveRecord::Base
    
    belongs_to :vault
    validates  :vault_id, presence: true, uniqueness: false
    validates  :value,    presence: true
    
    before_validation :generate_value
    
private
    
    def generate_value(places = 5)
      self.value ||= places.times.map { Random.rand(10) }.join("")
    end
    
  end
end
