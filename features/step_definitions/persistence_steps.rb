Then(/^I am not recognized$/) do
  show_me_the_cookies
  cookie = get_me_the_cookie('gringotts_recognized')
  cookie.present?.should be_false
#  gringotts_recognized?.should be_false
end

Then(/^I am recognized$/) do
  show_me_the_cookies
  cookie = get_me_the_cookie('gringotts_recognized')
  cookie.present?.should be_true
#  gringotts_recognized?.should be_true
end