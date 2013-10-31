require 'spec_helper'

module Gringotts
  describe Config do

    before(:each) do
      @missing_required = { "test" => { "asdf" => true } }.to_yaml
      @enabled = { "test" => { "enabled" => true } }.to_yaml
      @disabled = { "test" => { "enabled" => false } }.to_yaml
      @nested = { "test" => { "enabled" => true, "twilio" => { "account_sid" => "example_sid", "auth_token" => "example_token" } } }.to_yaml
    end
    
    it "should error out on invalid YAML" do
      expect { Gringotts::Config.load(nil) }.to raise_error
    end

    it "should error out if missing a required value" do
      expect { Gringotts::Config.load(@missing_required) }.to raise_error
    end
    
    it "should *not* error out on valid YAML" do
      expect { Gringotts::Config.load(@enabled) }.to_not raise_error
    end
    
    it "should have saved the value it loads (enabled)" do
      Gringotts::Config.load(@enabled)
      Gringotts::Config.enabled.should == true
    end
    
    it "should have saved the value it loads (disabled)" do
      Gringotts::Config.load(@disabled)
      Gringotts::Config.enabled.should == false
    end
    
    it "should handle nested configs" do
      Gringotts::Config.load(@nested)
      Gringotts::Config.twilio["account_sid"].should == "example_sid"
      Gringotts::Config.twilio["auth_token"].should == "example_token"
    end
    
  end
end