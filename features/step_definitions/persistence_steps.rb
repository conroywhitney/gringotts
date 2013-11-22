Then(/^I am not recognized$/) do
  show_me_the_cookies
  gringotts_recognized?.should be_false
end

Then(/^I am recognized$/) do
  show_me_the_cookies
  gringotts_recognized?.should be_true
end