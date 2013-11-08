module Gringotts
  class Delivery < ActiveRecord::Base
    
    belongs_to :vault
    belongs_to :code

    attr_reader :strategy
    
    validates :vault_id,       presence: true, unique: false
    validates :code_id,        presence: true, unique: false
    validates :strategy_class, presence: true, unique: false
    validates :phone_number,   presence: true, unique: false

    before_validation :copy_delivery_details_from_vault
    # note: I don't usually like dependencies like this, but...
    # we can't initialize strategy until we have our defaults from above...
    before_validation :initialize_strategy
        
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

      # sigh -- another thing I'm not proud of...
      # this begin-rescue-end hides errors sometimes
      # but it's also necessary to validate invalid strategy initializations without bombing
      # just note: if you need to dig further into strategy-related errors
      # you might begin by commenting out exception handling here
      begin
        @strategy = self.strategy_class.constantize.new(delivery: self)
        valid = true
      rescue Exception => e
        self.error_message = e.message
        self.errors[:base] << "Unable to figure out how to deliver validation code"
        # rut roh
        # tests seem to have acquired a measure of indeterminism somehow
        # which is fun
        # of course
        # por que no ?
        valid = false
      end
      
      return valid
    end
    
    def successful?
      return !self.delivered_at.nil? && self.error_message.nil?
    end
    
    def deliver!      
      begin        
        # yes, this means that we will deliver texts in Rails.env.[dev|staging|production] modes
        # for that reason, set the phone_number_override setting in config/gringotts.yml
        # that way, you won't be sending codes to actual people!
        @strategy.deliver!
        
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
