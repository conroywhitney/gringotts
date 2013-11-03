module Gringotts
  class TwilioSMSStrategy
   
    def initialize(delivery)
      Rails.logger.debug "\n\n\nInitialized with delivery [#{delivery.inspect}]!!!!!!\n\n\n"
    end
    
    def deliver!
      Rails.logger.debug "\n\n\nDelivering!!!!!!\n\n\n"
    end
        
  end
end