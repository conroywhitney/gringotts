module Gringotts::DeliveryStrategies
  class BaseDeliveryStrategy
 
    def initialize(delivery)
=begin
      @delivery = delivery
      @phone_number = delivery.phone_number
      @code = delivery.code
=end
    end
    
    def deliver!
      raise NotImplementedError
    end
    
  end
end