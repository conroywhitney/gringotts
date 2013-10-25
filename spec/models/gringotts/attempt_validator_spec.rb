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
      
      it "stale? should error for stale codes" do
        Gringotts::AttemptValidator.new(@stale_attempt, @stale_code).stale?.should be_true
      end
    
      it "stale? should NOT error for fresh codes" do
        Gringotts::AttemptValidator.new(@good_attempt, @good_code).stale?.should be_false
      end
      
      it "should have a recent code" do
        @stale_attempt.vault.recent_code.should_not be_nil
      end
      
      it "should not be valid" do
        Gringotts::AttemptValidator.valid?(@stale_attempt).should be_false
      end
      
      it "should have an error message" do
        Gringotts::AttemptValidator.valid?(@stale_attempt)
        @stale_attempt.errors.first.last.should == "Code expired"
      end
    
    end
    
    context "used codes" do
      
      before(:each) do
        @used_attempt = FactoryGirl.create(:used_gringotts_attempt)
        @used_code    = @used_attempt.vault.recent_code_object
      end
      
      it "used? should error for codes already used" do
        Gringotts::AttemptValidator.new(@used_attempt, @used_code).used?.should be_true
      end
    
      it "used? should NOT error for codes NOT already used" do
        Gringotts::AttemptValidator.new(@good_attempt, @good_code).used?.should be_false
      end
      
      it "should have a recent code" do
        @used_attempt.vault.recent_code.should_not be_nil
      end
      
      it "should not be valid" do
        Gringotts::AttemptValidator.valid?(@used_attempt).should be_false
      end
      
      it "should have an error message" do
        Gringotts::AttemptValidator.valid?(@used_attempt)
        @used_attempt.errors.first.last.should == "Code already used"
      end
    
    end
    
    context "matching codes" do
      
      before(:each) do
        @good_attempt = FactoryGirl.create(:good_gringotts_attempt)
        @good_code    = @good_attempt.vault.recent_code_object
        # since this is just a test, make sure they're matching, mkday ?
        @good_attempt.code_received = @good_code.value
      end
      
      it "matches? should work for matching codes" do
        Gringotts::AttemptValidator.new(@good_attempt, @good_code).matches?.should be_true
      end
    
      it "matches? should NOT work for different codes" do
        Gringotts::AttemptValidator.new(@good_attempt, FactoryGirl.create(:different_gringotts_code)).matches?.should be_false
      end
    
      it "should have a recent code" do
        @good_attempt.vault.recent_code.should_not be_nil
      end
      
      it "should be valid" do
        Gringotts::AttemptValidator.valid?(@good_attempt).should be_true
      end
      
      it "should NOT have an error message" do
        Gringotts::AttemptValidator.valid?(@good_attempt)
        @good_attempt.errors.any?.should be_false
      end
      
    end
    
  end
end