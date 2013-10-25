module Gringotts
  class Code < ActiveRecord::Base
    
    belongs_to :vault
    validates  :vault_id, presence: true, uniqueness: false
    validates  :value,    presence: true
    
    before_validation :generate_value, :set_expires_at
    
    def generate_value(places = 5)
      self.value ||= places.times.map { Random.rand(10) }.join("")
    end
    
    def set_expires_at(expires = (Time.now + 5.minutes))
      self.expires_at ||= expires
    end
    
  end
end
