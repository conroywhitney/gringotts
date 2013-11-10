Then(/^I should see "(.*?)"$/) do |page_content|
  page.should have_content page_content
end

Then(/^I should not see "(.*?)"$/) do |page_content|
  page.should_not have_content page_content
end

Then(/^I click button "(.*?)"$/) do |content|
  click_button content
end

Then(/^I should see button "(.*?)"$/) do |content|
  page.should have_selector(:xpath, "//input[@value='#{content}']")
end