require 'spec_helper'

module Gringotts
  describe AttemptValidator do
    
    before(:each) do
    end
    
    context "stale code" do
      
      before(:each) do
        @stale_attempt = FactoryGirl.create(:stale_gringotts_attempt)
      end
    
      it "stale? should error for stale codes"
    
      it "stale? should NOT error for fresh codes"
    
    end
    
    context "used codes" do
      
      before(:each) do
        @used_attempt = FactoryGirl.create(:used_gringotts_attempt)
      end
      
      it "already_used? should error for codes already used"
    
      it "already_used? should NOT error for codes NOT already used"
    
    end
    
    context "matching codes" do
      
      before(:each) do
        @matching_attempt = FactoryGirl.create(:matching_gringotts_attempt)
      end
      
      it "matches? should work for matching codes"
    
      it "matches? should NOT work for different codes"
    
    end
    
    context "successful and unsuccessful" do
      
      it "unsuccessful should mark unsuccessful and add message"  
    
      it "successful should mark successful"
      
    end
    
  end
end