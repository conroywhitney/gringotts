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
  page.current_path.should == verification_path
end

Then(/^I should not see the verify page$/) do
  page.current_path.should_not == verification_path
end
