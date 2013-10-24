def gringotts_user
  return Gringotts::User.find(@user)
end

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
  find_field('settings[active]').should_not be_checked
end  
                                                                                                                                                                                                  
Then(/^my phone number should be blank$/) do                                                                                                                                                      
  find_field("settings[phone_number]").value == nil
end    

When(/^I check the opt\-in box$/) do                                                                                                                                                              
  check("settings_active")
  find_field('settings[active]').should be_checked
end                                                                                                                                                                                               
                   
When(/^I enter the phone number "(.*?)"$/) do |phone_number|
  fill_in "settings_phone_number", with: phone_number
  find_field("settings[phone_number]").value == phone_number
end                                                                                                                                                                                               
                                                                                                                                                                                                  
When(/^I click Cancel$/) do                                                                                                                                                                       
  click_link "Cancel Phone Verification setup"                                                                                                                               
end                                                                                                                                                                                               
                                                                                                                                                                                                  
Then(/^I am redirected to the root url$/) do                                                                                                                                                      
  page.current_path.should == main_app.root_path
end                                                                                                                                                                                               
                                                                                                                                                                                                  
Then(/^no settings were created$/) do     
  gringotts_user.settings.should be_nil
end

Then(/^my phone number was saved$/) do
  gringotts_user.settings.phone_number.should_not be_nil
end

When(/^I click Continue$/) do                                                                                                                                                                     
  click_button "Save and Continue"                                                                                                                               
end                                                                                                                                                                                               
                                                                                                                                                                                                  
Then(/^I receive a message "(.*?)"$/) do |message|                                                                                                                                            
  page.should have_content message
end

Then(/^I am redirected to the challenge page$/) do
  page.current_path.should == gringotts_engine.verification_path
end 
