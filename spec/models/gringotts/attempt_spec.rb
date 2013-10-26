require 'spec_helper'

module Gringotts
  describe Attempt do

    before(:each) do
      @attempt = FactoryGirl.build(:base_gringotts_attempt)
    end
    
    it "should require a user_id" do
      @attempt = FactoryGirl.build(:bad_without_vault_attempt)
      @attempt.valid?.should be_false
    end
    
    it "should require a code_received" do
      @attempt = FactoryGirl.build(:bad_without_code_attempt)
      @attempt.valid?.should be_false
    end
    
    it "should require a code_received of at least some length" do
      @attempt = FactoryGirl.build(:bad_without_code_attempt)
      @attempt.code_received = ""
      @attempt.valid?.should be_false
    end
    
    it "one less than maximum unsuccessful attempts should NOT lock vault" do
      (Gringotts::AttemptValidator::MAX_UNSUCCESSFUL_ATTEMPTS - 1).times do
        @attempt = FactoryGirl.create(:unsuccessful_gringotts_attempt)
      end
      
      @attempt.vault.locked?.should be_false
    end
    
    it "multiple unsuccessful attempts should lock vault" do
      Gringotts::AttemptValidator::MAX_UNSUCCESSFUL_ATTEMPTS.times do
        @attempt = FactoryGirl.create(:unsuccessful_gringotts_attempt)
      end
      
      @attempt.vault.locked?.should be_true
    end
    
    it "succesful attempt should unlock vault" do
      @attempt = FactoryGirl.build(:successful_gringotts_attempt)
      @gringotts = @attempt.vault

      @gringotts.lock!
      @attempt.save!
      @gringotts.reload.locked?.should be_false
    end
    
    it "unsuccesful attempt should NOT unlock vault" do
      @attempt = FactoryGirl.build(:unsuccessful_gringotts_attempt)
      @gringotts = @attempt.vault

      @gringotts.lock!
      @attempt.save!
      @gringotts.reload.locked?.should be_true
    end
    
  end
end
