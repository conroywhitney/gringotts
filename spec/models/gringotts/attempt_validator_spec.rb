require 'spec_helper'

module Gringotts
  describe AttemptValidator do
    
    before(:each) do
      @good_attempt = FactoryGirl.create(:good_gringotts_attempt)
      @good_code    = FactoryGirl.create(:good_gringotts_code)
    end
    
    context "stale code" do
      
      before(:each) do
        @stale_attempt = FactoryGirl.create(:stale_gringotts_attempt)
        @stale_code    = FactoryGirl.build(:stale_gringotts_code)
      end
      
      it "should have a vault"
      
      it "should have a recent code"
      
      it "should not be valid"
    
      it "stale? should error for stale codes" do
        Gringotts::AttemptValidator.new(@stale_attempt, @stale_code).stale?.should be_true
      end
    
      it "stale? should NOT error for fresh codes" do
        Gringotts::AttemptValidator.new(@good_attempt, @good_code).stale?.should be_false
      end
    
    end
    
    context "used codes" do
      
      before(:each) do
        @used_attempt = FactoryGirl.create(:used_gringotts_attempt)
        @used_code    = FactoryGirl.build(:good_gringotts_code)
      end

      it "should have a vault"
      
      it "should have a recent code"
      
      it "should not be valid"
      
      it "used? should error for codes already used" do
        Gringotts::AttemptValidator.new(@used_attempt, @used_code).used?.should be_true
      end
    
      it "used? should NOT error for codes NOT already used" do
        Gringotts::AttemptValidator.new(@good_attempt, @good_code).used?.should be_false
      end
    
    end
    
    context "matching codes" do
      
      before(:each) do
      end
      
      it "matches? should work for matching codes" do
        puts "SAME"
        @matching_code = Gringotts::Code.find_by(vault_id: @good_attempt.vault_id, value: @good_attempt.code_received)
        Gringotts::AttemptValidator.new(@good_attempt, @matching_code).matches?.should be_true
      end
    
      it "matches? should NOT work for different codes" do
        puts "DIFFERENT"
        Gringotts::AttemptValidator.new(@good_attempt, FactoryGirl.create(:different_gringotts_code)).matches?.should be_false
      end
    
    end
    
    context "successful and unsuccessful" do
      
      it "unsuccessful should mark unsuccessful and add message"  
    
      it "successful should mark successful"
      
    end
    
  end
end