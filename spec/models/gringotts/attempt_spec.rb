require 'spec_helper'

module Gringotts
  describe Attempt do

    before(:each) do
      @attempt = FactoryGirl.build(:base_gringotts_attempt)
    end
    
    it "should require a user_id" do
      @attempt = FactoryGirl.build(:bad_without_user_attempt)
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
    
    it ""
    
  end
end
