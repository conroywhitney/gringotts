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

When(/^I enter the correct code$/) do
  fill_in "attempt_code_received", with: gringotts.recent_code
end

Then(/^I am redirected to the settings page$/) do
  page.current_path.should == gringotts_engine.settings_path
end

Then(/^I am redirected to the success page$/) do
  page.current_path.should == gringotts_engine.success_path
end

Then(/^I see the verification form$/) do
  find("#new_attempt")
end

Then(/^\(Temporarily\) I see the expected verification code$/) do
  page.should have_content "Expected Code [#{gringotts.recent_code}]"
end

Then(/^my blank attempt was not logged$/) do
  gringotts.attempts.count.should == 0
end
                                 
Then(/^my invalid attempt was logged$/) do
  gringotts.attempts.last.successful?.should be_false
end

Then(/^my valid attempt was logged$/) do
  gringotts.attempts.last.successful?.should be_true
end

When(/^I enter the correct code after waiting too long$/) do
  code = gringotts.recent_code_object
  code.update_attributes(expires_at: (Time.now - Gringotts::AttemptValidator::CODE_FRESHNESS_LIMIT))
  fill_in "attempt_code_received", with: code.value
end

When(/^I enter the correct code but it has already been confirmed$/) do
  code = gringotts.recent_code_object
  Gringotts::Attempt.create!(vault_id: gringotts.id, code_received: code.value, successful: true)
  fill_in "attempt_code_received", with: code.value
end    
