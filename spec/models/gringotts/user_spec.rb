require 'spec_helper'

module Gringotts
  describe User do
    
    before(:each) do
    end
  
    it "new user should default to not active" do
      @user = FactoryGirl.build(:gringotts_user)
      @user.active?.should be_false
    end
    
    it "phone number can be blank for inactive user" do
      @user = FactoryGirl.build(:gringotts_user)
      @user.phone_number = nil
      @user.valid?.should be_true
    end
    
    it "phone number can NOT be blank for active user" do
      @user = FactoryGirl.build(:bad_phone_number_missing_user)
      @user.valid?.should be_false
    end
    
    it "phone number should not validate when it's a bad number" do
      @user = FactoryGirl.build(:bad_phone_number_user)
      @user.valid?.should be_false
    end
    
    it "phone number should validate when it's a good number" do
      @user = FactoryGirl.build(:good_us_phone_number_user)
      @user.valid?.should be_true
    end
    
    it "phone number should validate when it's a good INTL number" do
      @user = FactoryGirl.build(:good_pe_phone_number_user)
      @user.valid?.should be_true
    end
    
  end
end
