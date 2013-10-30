require 'spec_helper'

module Gringotts
  describe Vault do
    
    before(:each) do
      @main_app_user = FactoryGirl.create(:user)
      @gringotts     = FactoryGirl.create(:good_gringotts_vault)
      @settings      = FactoryGirl.create(:good_us_phone_number_settings)
    end

    it "should be possible to 'find' by a given user object" do
      gringotts = Gringotts::Vault.for_owner(@main_app_user)
      gringotts.owner.id.should == @main_app_user.id
      gringotts.owner.class.name.should == @main_app_user.class.name
    end
    
    it "should require a user_id" do
      @gringotts = FactoryGirl.build(:bad_missing_owner_gringotts_vault)
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
    
    it "should be able to generate new codes" do
      @gringotts.new_code.should_not be_nil
    end
    
    it "the last generated code should be the recent code" do
      @gringotts.new_code.should == @gringotts.recent_code
    end

    it "should be lockable" do
      @gringotts.locked?.should be_false
      @gringotts.lock!
      @gringotts.reload.locked?.should be_true
    end
    
    it "should be locked if within timeframe" do
      FactoryGirl.create(:locked_gringotts_vault).locked?.should be_true
    end

    it "should not be locked if outside timeframe" do
      FactoryGirl.create(:unlockable_gringotts_vault).locked?.should be_false
    end
    
    it "should be unlockable" do
      @gringotts = FactoryGirl.create(:locked_gringotts_vault)
      @gringotts.locked?.should be_true
      @gringotts.unlock!
      @gringotts.reload.locked?.should be_false
    end
    
  end
end
