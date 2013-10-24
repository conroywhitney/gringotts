require 'spec_helper'

module Gringotts
  describe Vault do
    
    before(:each) do
      @main_app_user = FactoryGirl.create(:user)
      @gringotts     = FactoryGirl.create(:good_gringotts_vault)
      @settings      = FactoryGirl.create(:good_us_phone_number_settings)
    end

    it "should be possible to 'find' by a given user object" do
      gringotts = Gringotts::Vault.find_by(user_id: @main_app_user.id)
      gringotts.user.email.should == @main_app_user.email
    end
    
    it "should require a user_id" do
      @gringotts = FactoryGirl.build(:bad_missing_user_gringotts_vault)
      @gringotts.valid?.should be_false
    end

    it "should validate when valid" do
      @gringotts.valid?.should be_true
    end
    
    it "should have access to settings" do
      @gringotts.settings.should_not be_nil
    end
    
    it "should be considered 'opted-in' if have settings" do
      @gringotts.settings.should_not be_nil
      @gringotts.opted_in?.should be_true
    end
    
    it "should not be considered 'opted-in' if not have settings" do
      @settings.destroy
      @gringotts.settings.should be_nil
      @gringotts.opted_in?.should be_false
    end
    
    it "should always have a reference to the most-recent settings" do
      new_phone_number = "(800) 555-1212"
      @settings.update_attributes(phone_number: new_phone_number)
      @gringotts.settings.phone_number.should == new_phone_number
    end
    
    it "should have access to outgoing logs"
    
    it "should have access to incoming logs"
    
  end
end
