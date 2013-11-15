def opt_in
  click_link "Edit account"
  click_link "Add your mobile phone to this account now"  
  fill_in "settings_phone_number", with: "444-444-4444"
  click_button "Save and continue"
end

def submit_code(code)
  fill_in "attempt_code_received", with: code
  click_button "Verify"
end

Given(/^I am opted\-in$/) do
  create_user
  sign_in
  opt_in
  gringotts.settings.should_not be_nil
end

Given(/^I am not opted\-in$/) do
  gringotts.settings.should be_nil
end

Given(/^I am confirmed$/) do
  create_user
  sign_in
  opt_in
  submit_code gringotts.recent_code.value
  gringotts.confirmed?.should be_true
end

When(/^I need to confirm my phone number$/) do
  create_user
  sign_in
  opt_in
end

Given (/^I am locked out$/) do
  create_user
  sign_in
  opt_in
  submit_code gringotts.recent_code.value
  sign_out  
  sign_in
  Gringotts::AttemptValidator::MAX_UNSUCCESSFUL_ATTEMPTS.times do
    submit_code "F4!L"
  end
  gringotts.reload.locked_at.should_not be_nil
end

Given(/^I am on the verification page$/) do
  page.current_path.should == gringotts_engine.verification_path
end

Given(/^I go to the verification page$/) do
  visit gringotts_engine.verification_path
end

When(/^I enter a blank code$/) do
  submit_code ""
end

When(/^I enter the code "(.*?)"$/) do |code|
  submit_code code
end

When(/^I enter the correct code$/) do
  submit_code gringotts.recent_code.value
end

Then(/^I am redirected to the setup page$/) do
  page.current_path.should == gringotts_engine.setup_path
end

Then(/^I am redirected to the success page$/) do
  page.current_path.should == gringotts_engine.success_path
end

Then(/^I am redirected to the locked page$/) do
  page.current_path.should == gringotts_engine.locked_path
end

Then(/^I see the verification form$/) do
  find("#new_attempt").should_not be_nil
end

Then(/^I do not see the verification form$/) do
  page.should have_no_selector(:xpath, "//form[@id='new_attempt']")
end

Then(/^\(Temporarily\) I see the expected verification code$/) do
  page.should have_content "Expected Code [#{gringotts.recent_code.value}]"
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

Then (/^my account is locked$/) do
  gringotts.locked_at.should_not be_nil
end

Then (/^my account is not locked$/) do
  gringotts.locked_at.should be_nil
end

When(/^I enter the correct code after waiting too long$/) do
  code = gringotts.recent_code
  code.update_attributes(expires_at: (Time.now - Gringotts::AttemptValidator::CODE_FRESHNESS_LIMIT))
  submit_code code.value
end

When(/^I enter the correct code but it has already been confirmed$/) do
  code = gringotts.recent_code
  Gringotts::Attempt.create!(vault_id: gringotts.id, code_received: code.value, successful: true)
  submit_code code.value
end

Given(/^I enter too many invalid codes$/) do
  Gringotts::AttemptValidator::MAX_UNSUCCESSFUL_ATTEMPTS.times do
    submit_code "F4!L"
  end
end 

Then(/^I do not see my phone number$/) do
  page.should_not have_content "444-444-4444"
end

Then(/^I should see my phone number$/) do
  page.should have_content "444-444-4444"
end

Then(/^I see the last (\d+) digits of my phone number$/) do |num|
  page.should_not have_content "(***) *** - 4444"
end
