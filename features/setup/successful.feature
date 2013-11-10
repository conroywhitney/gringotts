Feature: Setting Up New Account
  In order to set up a Gringotts account
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
        And my phone number should be blank

    Scenario: New user opts-in and gives correct phone number
      Given I am logged in
        And I do not have any gringotts settings
      When I go to the gringotts settings page
        And I enter the phone number "(406) 444-4444"
        And I click Continue
      Then my phone number was saved
        And I am opted-in
        And I am redirected to the challenge page
      
