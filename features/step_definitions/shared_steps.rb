Then(/^I should see "(.*?)"$/) do |page_content|
  page.should have_content page_content
end

Then(/^I should not see "(.*?)"$/) do |page_content|
  page.should_not have_content page_content
end