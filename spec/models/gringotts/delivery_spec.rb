require 'spec_helper'

module Gringotts
  describe Delivery do
    
    context "good delivery" do
      before(:each) do
        @good_delivery = FactoryGirl.create(:good_gringotts_delivery)
      end
      
      it "should have a valid vault after initialization" do
        @good_delivery.vault.should_not be_nil
      end
      
      it "should have a valid phone number after initialization" do
        @good_delivery.phone_number.should_not be_nil
      end
      
      it "should have a valid sending strategy after initialization" do
        @good_delivery.strategy.should_not be_nil
      end
      
      it "should have a sending strategy of the same name as saved" do
        @good_delivery.strategy.class.name.should == @good_delivery.strategy_class
      end
      
      it "should have a delivered_at for valid deliveries" do
        @good_delivery.deliver!
        @good_delivery.delivered_at.should_not be_nil
      end
        
      it "should not have error message for valid deliveries" do
        @good_delivery.deliver!
        @good_delivery.error_message.should be_nil
      end
        
      it "should be successful if delivered correctly" do
        @good_delivery.deliver!
        @good_delivery.successful?.should be_true
      end
    end
    
    context "invalid initialization" do
      it "should not be able to be created without a valid sending strategy" do
        expect { FactoryGirl.create(:bad_invalid_strategy_gringotts_delivery) }.to raise_error
      end
    end
      
    context "bad delivery" do
      
      before(:each) do
        @error_delivery = FactoryGirl.create(:error_raising_gringotts_delivery)
      end
          
      it "should not have a delivered_at if not delivered" do
        @error_delivery.deliver!
        @error_delivery.delivered_at.should be_nil
      end
        
      it "should have an error message for deliveries that raise errors" do
        @error_delivery.deliver!  
        @error_delivery.error_message.should == "Error message from ErrorRaisingStrategy"
      end
          
      it "should not be successful if error'd" do
        @error_delivery.deliver!  
        @error_delivery.successful?.should == false
      end      
    end
      
  end
end
