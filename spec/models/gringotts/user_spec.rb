require 'spec_helper'

module Gringotts
  describe User do
    
    before(:each) do
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
