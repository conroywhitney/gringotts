require 'spec_helper'

module Gringotts
  describe Config do

    before(:each) do
      @missing_required = { "test" => { "asdf" => true } }.to_yaml
      @good = { "test" => { "enabled" => true } }.to_yaml
      @disabled = { "test" => { "enabled" => false } }.to_yaml
    end
    
    it "should error out on invalid YAML" do
      expect { Gringotts::Config.load(nil) }.to raise_error
    end

    it "should error out if missing a required value" do
      expect { Gringotts::Config.load(@missing_required) }.to raise_error
    end
    
    it "should *not* error out on valid YAML" do
      expect { Gringotts::Config.load(@good) }.to_not raise_error
    end
    
    it "should have saved the value it loads (enabled)" do
      Gringotts::Config.load(@good)
      Gringotts::Config.enabled.should == true
    end
    
    it "should have saved the value it loads (disabled)" do
      Gringotts::Config.load(@disabled)
      Gringotts::Config.enabled.should == false
    end
    
  end
end