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

When(/^I check the opt\-in box$/) do                                                                                                                                                              
  check("user_active")
  find_field('user[active]').should be_checked
end                                                                                                                                                                                               
                                                                                                                                                                                                  
When(/^I enter a phone number$/) do                                                                                                                                                               
  fill_in "user_phone_number", with: "406-555-1212"
  find_field("user[phone_number]").value == "406-555-1212"
end                                                                                                                                                                                               
                                                                                                                                                                                                  
When(/^I click Cancel$/) do                                                                                                                                                                       
  click_link "Cancel Phone Verification setup"                                                                                                                               
end                                                                                                                                                                                               
                                                                                                                                                                                                  
Then(/^I am redirected to the root url$/) do                                                                                                                                                      
  page.current_path.should == main_app.root_path
end                                                                                                                                                                                               
                                                                                                                                                                                                  
Then(/^none of my information was saved$/) do                                                                                                                                                     
  @user.active?.should be_false
  @user.phone_number.should be_nil
end
