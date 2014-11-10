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
    
    it "confirmed_at should be blank after editing phone number" do
      @settings = FactoryGirl.create(:confirmed_settings)
      @settings.vault.confirmed_at.should_not be_nil
      
      @settings.update_attributes!(phone_number: "+1 555-555-5555")
      @settings.vault.confirmed_at.should be_nil
    end
    
  end
end
