When(/^I got to my account details page$/) do                                                                                                                                                     
  click_link "Edit account"
end  
  
Then(/^I see a link to edit my gringotts settings$/) do                                                                                                                                           
  page.should have_content "Add your mobile phone to this account now"
end  

When(/^I go to the gringotts settings page$/) do                                                                                                                                                  
  pending # express the regexp above with the code you wish you had                                                                                                                               
end                                                                                                                                                                                               
                                                                                                                                                                                                  
Then(/^I see an information message$/) do                                                                                                                                                         
  pending # express the regexp above with the code you wish you had                                                                                                                               
end                                                                                                                                                                                               
                                                                                                                                                                                                  
Then(/^my phone number should be blank$/) do                                                                                                                                                      
  pending # express the regexp above with the code you wish you had                                                                                                                               
end    