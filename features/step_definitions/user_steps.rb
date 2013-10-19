Given(/^I am an existing user$/) do                                                                                                                                                               
  pending # express the regexp above with the code you wish you had                                                                                                                               
end                                                                                                                                                                                               
                                                                                                                                                                                                  
Given(/^I do not exist as a gringotts user$/) do
  # TODO
  @user = FactoryGirl.create(:gringotts_user)
  @user.active?.should be_false
end                                                                                                                                                                                               
                                                                                                                                                                                                  