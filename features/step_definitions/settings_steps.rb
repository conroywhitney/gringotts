Given(/^I have gringotts settings$/) do                                                                                                                                                               
  pending # express the regexp above with the code you wish you had                                                                                                                               
end                                                                                                                                                                                               
                                                                                                                                                                                                  
Given(/^I do not have any gringotts settings$/) do
  create_user
  sign_in
  @settings = FactoryGirl.create(:base_settings)
end                                                                                                                                                                                               
                                                                                                                                                                                                  