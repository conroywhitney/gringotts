require 'spec_helper'

module Gringotts
  describe Settings do
    
    before(:each) do
    end
    
    it "phone number can NOT be blank for active settings" do
      @settings = FactoryGirl.build(:bad_phone_number_missing_settings)
      @settings.valid?.should be_false
    end
    
    it "phone number should not validate when it's a bad number" do
      @settings = FactoryGirl.build(:bad_phone_number_settings)
      @settings.valid?.should be_false
    end
    
    it "phone number should validate when it's a good number" do
      @settings = FactoryGirl.build(:good_us_phone_number_settings)
      @settings.valid?.should be_true
    end
    
    it "phone number should validate when it's a good INTL number" do
      @settings = FactoryGirl.build(:good_pe_phone_number_settings)
      @settings.valid?.should be_true
    end
    
  end
end
