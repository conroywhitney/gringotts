Feature: Unsuccessful Attempts
  In order to verify access to an account
  A user who submits incorrect codes
  Is not granted access

  Scenario: User submits a blank code
      Given I am logged in
        And I am opted-in
        And I am on the verification page
      When I enter a blank code
      Then I receive a message "Code was incorrect. Please try again."
        And my blank attempt was not logged
      
    Scenario: User submits an invalid code
      Given I am logged in
        And I am opted-in
        And I am on the verification page
      When I enter the code "asdf"
      Then I receive a message "Code was incorrect. Please try again."
        And my invalid attempt was logged
        And (Temporarily) I see the expected verification code
        
    Scenario: User submits a stale code
      Given I am logged in
        And I am opted-in
        And I am on the verification page
      When I enter the correct code after waiting too long
      Then I receive a message "Code was incorrect. Please try again."
        And my invalid attempt was logged
        And (Temporarily) I see the expected verification code

    Scenario: User submits a code that's already been confirmed
      Given I am logged in
        And I am opted-in
        And I am on the verification page
      When I enter the correct code but it has already been confirmed
      Then I receive a message "Code was incorrect. Please try again."
        And my invalid attempt was logged
        And (Temporarily) I see the expected verification code
