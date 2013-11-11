require 'twilio-rb'

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
      @to   = @phone_number
      @from = Gringotts::Config.twilio.present? ? Gringotts::Config.twilio["from_number"] : nil
      @body = "Your validation code is [#{@code}]"
      
      # finally, the moment we've all been waiting for!
      # oh, but don't send in test mode ... cuz ... that's a lot of useless SMSsss
      Twilio::SMS.create(to: @to, from: @from, body: @body) unless Rails.env.test?
    end
        
  end
end