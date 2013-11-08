module Gringotts::DeliveryStrategies
  class TwilioSMSStrategy < BaseDeliveryStrategy

    def initialize(delivery)
      super(delivery)
      if Gringotts::Config.twilio.nil?
        raise "You must add your Twilio account information to config/gringotts.yml"
      else
        Twilio::Config.setup(
          account_sid: Gringotts::Config.twilio["account_sid"],
          auth_token:  Gringotts::Config.twilio["auth_token"]
        )
      end
    end
    
    def deliver!
      # don't send in test mode ... cuz ... that's a lot of SMSsss
      unless Rails.env.test?
        Twilio::SMS.create(
          to:   @phone_number,
          from: '+1-406-282-0474',
          body: "Your validation code is [#{@code}]"
        )
      end
    end
        
  end
end