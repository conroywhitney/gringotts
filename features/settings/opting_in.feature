Feature: Opting In
  In order to use gringotts
  A existing user
  Should be able to opt in

    Scenario: User sees link to gringotts settings from account edit page
      Given I am logged in
      When I got to my account details page
      Then I see a link to edit my gringotts settings

    Scenario: User goes to settings page for the first time
      Given I am logged in
        And I do not have any gringotts settings
      When I go to the gringotts settings page
      Then I see an information message
        And phone verification should be turned off
        And my phone number should be blank
        
    Scenario: New user changes mind and wants to cancel setup
      Given I am logged in
        And I do not have any gringotts settings
      When I go to the gringotts settings page
        And I check the opt-in box
        And I enter the phone number "(406) 555-1212"
        And I click Cancel
      Then I am redirected to the root url
        And no settings were created
        
    Scenario: New user opts-in but does not give phone number
      Given I am logged in
        And I do not have any gringotts settings
      When I go to the gringotts settings page
        And I check the opt-in box
        And I click Continue
      Then I receive a message "Phone number can't be blank"
        And no settings were created
        
    Scenario: New user opts-in but gives an invalid phone number
      Given I am logged in
        And I do not have any gringotts settings
      When I go to the gringotts settings page
        And I check the opt-in box
        And I enter the phone number "12345"
        And I click Continue
      Then I receive a message "Phone number is an invalid number"
        And no settings were created

    Scenario: New user opts-in and gives correct phone number
      Given I am logged in
        And I do not have any gringotts settings
      When I go to the gringotts settings page
        And I check the opt-in box
        And I enter the phone number "(406) 444-4444"
        And I click Continue
      Then I receive a message "Successfully added phone number"
        And my phone number was saved
        And I am opted-in
        And I am redirected to the challenge page
      
