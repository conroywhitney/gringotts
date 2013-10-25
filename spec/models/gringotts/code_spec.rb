require 'spec_helper'

module Gringotts
  describe Code do
    
    before(:each) do
      @code = FactoryGirl.create(:good_gringotts_code)
    end
    
    it "should generate a code" do
      @code.value.should_not be_nil
    end
    
    it "should by default generate a code of length 5" do
      @code.value.length == 5
    end
    
    it "should by default be a number between 0 and 100,000" do
      @code.value.to_i >= 0 && @code.value.to_i < 100000
    end
    
  end
end
