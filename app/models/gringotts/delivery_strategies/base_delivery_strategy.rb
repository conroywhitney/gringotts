module Gringotts::DeliveryStrategies
  class BaseDeliveryStrategy
 
    def initialize(h)
      delivery = h[:delivery]
        
      # unless you are in production, you should probably not be delivering codes to live phone numbers
      # change delivery/phone_number_override in config/gringotts.yml to your personal number if you are testing something in dev
      # or just set delivery/enabled to false if you don't want to deliver any codes at all
      # note: there are some legit circumstances where you want to send in dev (like
      # TODO: could this be refactored so that the delivery object decides this, instead of the strategy ?
      if Rails.env.production?
        @phone_number = delivery.phone_number
      elsif Rails.env.development?
        @phone_number = Gringotts::Config.delivery['phone_number_override']
      else
        @phone_number = nil
      end
      
      @code = delivery.code.value
    end
    
    def deliver!
      raise NotImplementedError
    end
    
  end
end