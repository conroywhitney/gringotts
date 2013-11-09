module Gringotts::DeliveryStrategies
  class TestStubStrategy < BaseDeliveryStrategy

    def initialize(delivery)
      super(delivery)
    end
    
    def deliver!
      # don't actually do anything ...
      return true
    end
        
  end
end