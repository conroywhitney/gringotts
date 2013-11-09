module Gringotts
  class Delivery < ActiveRecord::Base
    
    belongs_to :vault
    belongs_to :code

    attr_reader :strategy
    
    validates :vault_id,       presence: true, unique: false
    validates :code_id,        presence: true, unique: false
    validates :strategy_class, presence: true, unique: false
    validates :phone_number,   presence: true, unique: false

    # bear in mind that order matters with these validators...
    before_validation :verify_vault
    before_validation :snapshot_values_from_vault
    before_validation :initialize_delivery_strategy
    
    def verify_vault
      if self.vault.nil?
        self.errors[:defaults] = "Must have valid Gringotts::Vault"
        return false
      end
    end
    
    def snapshot_values_from_vault
      # these values are temporal -- if we check later, they may have changed
      # therefore, save a copy of them as part of this object for posterity's sake
      
      # record which code we're actually going to send
      self.code = self.vault.recent_code
      
      # record the phone number that we're actually going to send to
      self.phone_number = self.vault.phone_number
    
      # since we're not technically validating things (just setting defaults)
      # always return true so as not to block the callback chain
      return true
    end
    
    def initialize_delivery_strategy
      @strategy = nil
      valid = true
      
      # set a default delivery strategy if not initialized with one
      # TODO: can read the default strategy from Gringotts::Config for flexibility
      self.strategy_class ||= "Gringotts::DeliveryStrategies::TwilioSMSStrategy"
    
      begin
        @strategy = strategy_class.constantize.new(delivery: self)
      rescue Exception => e
        self.errors[:delivery_strategy] = "Requires a valid Delivery Strategy [#{e.message}]"
        valid = false
      end
      
      return valid
    end
    
    def successful?
      return !self.delivered_at.nil? && self.error_message.nil?
    end
    
    def deliver!
      success = false
      
      begin        
        # set the phone_number_override setting in config/gringotts.yml
        # that way, you won't be sending codes to actual people!
        # note: spec tests use a stub class with an empty deliver method
        @strategy.deliver! unless Gringotts::Config.delivery['enabled'] == false
        
        # only update delivered_at (success indicator) if we didn't bomb
        self.delivered_at = Time.now
        success = true
      rescue Exception => e
        # some error sending -- log message for later analysis
        self.error_message = e.message
      ensure
        self.save!  
      end
      
      return success
    end
    
  end
end
