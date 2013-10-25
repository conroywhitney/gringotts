def opt_in
  click_link "Edit account"
  click_link "Add your mobile phone to this account now"  
  check("settings_active")
  fill_in "settings_phone_number", with: "(828) 555-1212"
  click_button "Save and Continue"
end

Given(/^I am opted\-in$/) do
  opt_in
  gringotts.settings.should_not be_nil
end

Given(/^I am not opted\-in$/) do
  gringotts.should be_nil
end

Given(/^I am on the verification page$/) do
  page.current_path.should == gringotts_engine.verification_path
end

Given(/^I go to the verification page$/) do
  visit gringotts_engine.verification_path
end

When(/^I enter a blank code$/) do
  fill_in "attempt_code_received", with: ""
end

When(/^I press submit$/) do
  click_button "Verify"
end

When(/^I enter the code "(.*?)"$/) do |code|
  fill_in "attempt_code_received", with: code
end

Then(/^I am redirected to the settings page$/) do
  page.current_path.should == gringotts_engine.settings_path
end

Then(/^I see the verification form$/) do
  find("#new_attempt")
end

Then(/^I see the expected verification code$/) do
  pending
end

Then(/^my blank attempt was not logged$/) do
  gringotts.attempts.count.should == 0
end
                                 
Then(/^my invalid attempt was logged$/) do
  my_attempt = gringotts.attempts.last
  my_attempt.successful?.should be_false
end
