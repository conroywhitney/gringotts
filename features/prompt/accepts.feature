Feature: First-Time User Accepts
  In order to add security to as many accounts as possible
  A user is shown the opt-in option once after login
  And can continue on to set up Gringotts 2FA

  Scenario: User who logs in sees prompt for first time
    Given I exist as a user
      But I am not logged in
    When I sign in with valid credentials
      And I should see the opt-in prompt

  Scenario: User who clicks continue goes on to setup page
    Given I exist as a user
      But I am not logged in
    When I sign in with valid credentials
    Then I should see the opt-in prompt
    When I click "Continue"
    Then I am redirected to the setup page

  Scenario: Opted-in user should not see the prompt
    Given I am opted-in
      But I am not logged in
    When I sign in with valid credentials
    Then I should not see the opt-in prompt 
