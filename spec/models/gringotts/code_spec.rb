require 'spec_helper'

module Gringotts
  describe Code do
    
    before(:each) do
      @code     = FactoryGirl.create(:good_gringotts_code)
      @new_code = FactoryGirl.build(:base_gringotts_code)
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
    
    it "should have a blank code until generated" do
      @new_code.value.should be_nil
    end
    
    it "should create a default code if not specified" do
      @new_code.generate_value
      @new_code.value.should_not be_nil
    end
    
    it "should use passed-in code length if present" do
      @new_code.generate_value(3)
      @new_code.value.length.should == 3
    end
    
    it "should NOT create a a code if already have one" do
      @new_code.value = "asdf"
      @new_code.generate_value
      @new_code.value.should == "asdf"
    end
    
    it "should have a blank expires_at until generated" do
      @new_code.expires_at.should be_nil
    end
    
    it "should create a default expires_at if not specified" do
      @new_code.set_expires_at
      @new_code.expires_at.should_not be_nil
    end
    
    it "should use passsed-in expires_at if present" do
      expires = Time.now + 1.day
      @new_code.set_expires_at(expires)
      @new_code.expires_at.should == expires
    end
    
    it "should not overwrite expires_at if already set" do
      expires = Time.now + 1.day
      @new_code.set_expires_at(expires)
      @new_code.set_expires_at
      @new_code.expires_at.should == expires
    end
    
    
  end
end
