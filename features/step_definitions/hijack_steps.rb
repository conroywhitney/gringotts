=begin
def verify
  click_link "Edit account"
  click_link "Add your mobile phone to this account now"  
  check("settings_active")
  fill_in "settings_phone_number", with: "(828) 555-1212"
  click_button "Save and Continue"
end
=end

When(/^I navigate to an un\-protected page$/) do
  visit '/'
end

When(/^I navigate to a protected page$/) do
  visit '/users/edit'
end

Then(/^I should be asked to sign in$/) do
  page.should have_content "You need to sign in or sign up before continuing."
end

Then(/^I should see the verify page$/) do
  page.current_path.should == gringotts_engine.verification_path
end

Then(/^I should not see the verify page$/) do
  page.current_path.should_not == gringotts_engine.verification_path
end

Given(/^I am verified$/) do
  pending
end