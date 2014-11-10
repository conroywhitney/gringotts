require 'spec_helper'

module Gringotts
  describe Vault do
    
    before(:each) do
      @main_app_user = FactoryGirl.create(:user)
      @gringotts     = FactoryGirl.create(:good_gringotts_vault)
      @settings      = FactoryGirl.create(:good_us_phone_number_settings)
    end

    it "should be possible to 'find' by a given owner object" do
      gringotts = Gringotts::Vault.for_owner(@main_app_user)
      gringotts.owner.id.should == @main_app_user.id
      gringotts.owner.class.name.should == @main_app_user.class.name
    end
    
    it "should require a owner_id" do
      @gringotts = FactoryGirl.build(:bad_missing_owner_gringotts_vault)
      @gringotts.valid?.should be_false
    end

    it "should validate when valid" do
      @gringotts.valid?.should be_true
    end
    
    it "should have access to settings" do
      @gringotts.settings.should_not be_nil
    end
    
    it "should be considered 'opted-in' if confirmed" do
      @gringotts.confirm!
      @gringotts.opted_in?.should be_true
    end
    
    it "should not be considered 'opted-in' if not confirmed" do
      @gringotts.opted_in?.should be_false
    end
    
    it "should always have a reference to the most-recent settings" do
      new_phone_number = "(800) 555-1212"
      @settings.update_attributes(phone_number: new_phone_number)
      @gringotts.settings.phone_number.should == '18005551212'
    end
    
    it "should be able to generate new codes" do
      @gringotts.new_code.should_not be_nil
    end
    
    it "the last generated code should be the recent code" do
      @gringotts.new_code.should == @gringotts.recent_code
    end
        
    it "should generate a code if there is no recent code" do
      @gringotts.recent_code.should_not be_nil
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
        
    it "should by default have confirmed_at blank" do
      @gringotts.confirmed_at.should be_nil
    end
    
    it "should set confirmed at correctly when confirming" do
      @gringotts.confirm!
      @gringotts.confirmed_at.should_not be_nil
    end
    
    it "should not overwrite confirmed_at when re-confirming" do
      @gringotts.confirm!
      dt = @gringotts.confirmed_at
      @gringotts.confirm!
      @gringotts.confirmed_at.should == dt
    end
        
    it "should modify session to include expires_at" do
      session = {}
      @gringotts.verify!(session)
      session[Gringotts::Vault::SESSION_FRESHNESS_KEY].should_not be_nil
    end
    
    it "should be verified for a fresh date" do
      session = {}
      @gringotts.verify!(session)
      @gringotts.verified?(session).should be_true
    end
    
    it "should not be verified for an old date" do
      session = { Gringotts::Vault::SESSION_FRESHNESS_KEY => (Time.now - 1.seconds) }
      @gringotts.verified?(session).should be_false
    end
        
    it "one less than maximum unsuccessful attempts should NOT lock vault" do
      @gringotts.confirm!
      
      (Gringotts::AttemptValidator::MAX_UNSUCCESSFUL_ATTEMPTS - 1).times do
        @attempt = FactoryGirl.create(:unsuccessful_gringotts_attempt)
      end
      
      @gringotts.should_lock?.should be_false
    end
    
    it "multiple unsuccessful attempts should lock vault" do
      @gringotts.confirm!
      
      Gringotts::AttemptValidator::MAX_UNSUCCESSFUL_ATTEMPTS.times do
        @attempt = FactoryGirl.create(:unsuccessful_gringotts_attempt)
      end
      
      @gringotts.should_lock?.should be_true
    end
        
    it "should not lock if not yet confirmed" do
      (Gringotts::AttemptValidator::MAX_UNSUCCESSFUL_ATTEMPTS - 1).times do
        @attempt = FactoryGirl.create(:unsuccessful_gringotts_attempt)
      end
      
      @gringotts.should_lock?.should be_false      
    end

    it "should return the last 4 digits of phone number" do
      @gringotts.last_4.should == "4444"
    end
        
  end
end
