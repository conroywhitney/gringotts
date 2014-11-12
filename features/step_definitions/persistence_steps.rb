Then(/^I am not recognized$/) do
  cookie = get_me_the_cookie('gringotts_recognized')
  cookie.present?.should be_false
#  gringotts_recognized?.should be_false
end

Then(/^I am recognized$/) do
  cookie = get_me_the_cookie('gringotts_recognized')
  cookie.present?.should be_true
#  gringotts_recognized?.should be_true
end