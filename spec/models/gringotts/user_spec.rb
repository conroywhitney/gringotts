require 'spec_helper'

module Gringotts
  describe Settings do
    
    before(:each) do
      @main_app_user = FactoryGirl.create(:user)
      @user = Gringotts::User.new(@main_app_user)
      @settings = FactoryGirl.create(:good_us_phone_number_settings)
    end

    it "should be possible to 'find' by a given user object" do
      Gringotts::User.find(@main_app_user).email.should == @main_app_user.email
    end
    
    it "should not be able to be constructed without a user" do
      expect { @user = Gringotts::User.new }.to raise_error
    end

    it "should be able to reference its user's properties as its own" do
      @user.email.should == @main_app_user.email
    end
    
    it "should have access to settings" do
      @user.settings.should_not be_nil
    end
    
    it "should always have a reference to the most-recent settings" do
      new_phone_number = "(800) 555-1212"
      @settings.update_attributes(phone_number: new_phone_number)
      @user.settings.phone_number.should == new_phone_number
    end
    
    it "should have access to outgoing logs"
    
    it "should have access to incoming logs"
    
  end
end
