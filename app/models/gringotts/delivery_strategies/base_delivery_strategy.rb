module Gringotts::DeliveryStrategies
  class BaseDeliveryStrategy
 
    def initialize(h)
      delivery = h[:delivery]
      
      # if in test or dev, NEVER EVER EVER send to a real number
      # that will confuse the hell outa someone
      # this ensures that all SMS deliveries go to a configurable phone number
      # change this in config/gringotts.yml
      # use your personal phone number if you are testing something in dev
      # use a null number if you are testing something in test 
      # TODO: this doesn't bode well, what with errors that could possibly only happen in production...
      # also, could be refactored so that the delivery object decides this, instead of the strategy, no?
      @phone_number = Rails.env.production? ? delivery.phone_number : Gringotts::Config.phone_number_override
      
      @code = delivery.code.value
    end
    
    def deliver!
      raise NotImplementedError
    end
    
  end
end