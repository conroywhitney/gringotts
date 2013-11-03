require 'spec_helper'

module Gringotts
  describe Delivery do
    
    before(:each) do
      @settings = FactoryGirl.create(:good_us_phone_number_settings)
      @vault    = @settings.vault
      @vault.new_code
      
      @delivery = FactoryGirl.create(:base_gringotts_delivery)
    end
    
    it "should have a valid phone number after initialization" do
      @delivery.phone_number.should_not be_nil
    end
    
    it "should have a strategy_class after initialization" do
      @delivery.strategy_class.should_not be_nil
    end
    
  end
end
