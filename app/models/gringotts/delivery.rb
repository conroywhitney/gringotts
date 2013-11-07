module Gringotts
  class Delivery < ActiveRecord::Base
    
    belongs_to :vault
    belongs_to :code

    attr_reader :strategy
    
    validates :vault_id,       presence: true, unique: false
    validates :code_id,        presence: true, unique: false
    validates :strategy_class, presence: true, unique: false
    validates :phone_number,   presence: true, unique: false

    before_validation :initialize_strategy
    before_validation :copy_delivery_details_from_vault
        
    def copy_delivery_details_from_vault
      valid = true
      
      # these values are temporal -- if we check later, they may have changed
      # therefore, save a copy of them as part of this object for posterity's sake
      
      raise "Requires Gringotts::Vault" if self.vault.nil?
      
      # record which code we're actually going to send
      self.code = self.vault.recent_code || self.vault.new_code
      
      # record the phone number that we're actually going to send to
      self.phone_number = self.vault.phone_number
      
      return valid
    end
    
    def initialize_strategy
      # TODO: Make this an actual strategy that you can sub in and out based on the config file
      self.strategy_class ||= "Gringotts::DeliveryStrategies::TwilioSMSStrategy"
      
      begin
        @strategy = self.strategy_class.constantize.new(delivery: self.vault)
        valid = true
      rescue Exception => e
        self.error_message = e.message
        valid = false
      end
      
      return valid
    end
    
    def successful?
      return !self.delivered_at.nil? && self.error_message.nil?
    end
    
    def deliver!      
      begin        
        # don't execute the strategy in test environment
        # assuming in dev environment you're smart enough to use your own phone #
        # which, might not be the case, so maybe this should be "if Rails.env.production?"
        @strategy.deliver!# unless Rails.env.test?
        
        # only update delivered_at (success indicator) if we didn't bomb
        self.delivered_at = Time.now
      rescue Exception => e
        # some error sending -- log message for later analysis
        self.error_message = e.message
      ensure
        self.save!  
      end
    end
    
  end
end
