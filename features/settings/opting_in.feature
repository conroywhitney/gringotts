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
        And I do not exist as a gringotts user
      When I go to the gringotts settings page
      Then I see an information message
        And phone verification should be turned off
        And my phone number should be blank
