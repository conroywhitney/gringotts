When(/^I got to my account details page$/) do                                                                                                                                                     
  click_link "Edit account"
end  
  
Then(/^I see a link to edit my gringotts settings$/) do                                                                                                                                           
  page.should have_content "Add your mobile phone to this account now"
end  

When(/^I go to the gringotts settings page$/) do                                                                                                                                                  
  click_link "Edit account"
  click_link "Add your mobile phone to this account now"  
end                                                                                                                                                                                               
                                                                                                                                                                                                  
Then(/^I see an information message$/) do                                                                                                                                                         
  page.should have_content "Phone Verification"                                                                                                                               
end                

Then(/^phone verification should be turned off$/) do                                                                                                                                              
  find_field('user[active]').should_not be_checked
end  
                                                                                                                                                                                                  
Then(/^my phone number should be blank$/) do                                                                                                                                                      
  find_field("user[phone_number]").value == nil
end    