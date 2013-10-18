require 'spec_helper'

module Gringotts
  describe User do
    
    before(:each) do
    end
  
    it "new user should default to not active" do
      @user = FactoryGirl.create(:gringotts_user)
      @user.active?.should be_false
    end
  
    it "opted-in user should be active" do
      @user = FactoryGirl.create(:opted_in_user)
      @user.active?.should be_true
    end
    
  end
end
