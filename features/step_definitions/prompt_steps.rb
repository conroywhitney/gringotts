When(/^I should see the opt\-in prompt$/) do
  page.should have_content "Would you like to make your account more secure?"
end

Then(/^I should not see the opt\-in prompt$/) do
  page.should_not have_content "Would you like to make your account more secure?"
end

When(/^I decline opting in$/) do
  click_link "No, thanks"
end

When(/^I click "(.*?)"$/) do |link_text|
  click_link link_text
end
