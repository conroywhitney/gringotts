module Gringotts::DeliveryStrategies
  class ErrorRaisingStrategy < BaseDeliveryStrategy

    def deliver!
      raise "Error message from ErrorRaisingStrategy"
    end
    
  end
end
