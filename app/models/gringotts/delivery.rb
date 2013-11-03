module Gringotts
  class Delivery < ActiveRecord::Base
    
    belongs_to :vault
    belongs_to :code
    
    validates :vault_id,       presence: true, unique: false
    validates :code_id,        presence: true, unique: false
    validates :strategy_class, presence: true, unique: false
    validates :phone_number,   presence: true, unique: false

    before_validation  :after_initialize
    #before_create   :deliver!
    
    def after_initialize
      self.code           = self.vault.recent_code_object
      self.strategy_class = "Gringotts::TwilioSMSStrategy"
      self.phone_number   = self.vault.phone_number
    end
    
    def deliver!
      strategy = self.strategy_class.constantize.new(self)
      strategy.deliver! unless Rails.test?
    end
    
  end
end
