require 'spec_helper'

FactoryGirl.factories.map(&:name).each do |factory_name|
  describe "The #{factory_name} factory" do
    if factory_name.to_s.start_with? "bad_" or factory_name.to_s.start_with? "base_" then
      it 'is NOT valid' do
        FactoryGirl.build(factory_name).should_not be_valid
      end
    else
      it 'is valid' do
        FactoryGirl.build(factory_name).should be_valid
      end
    end
  end
end