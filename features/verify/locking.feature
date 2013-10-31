Feature: Locking
  In order to verify access to an account
  A user who has tried to log in incorrectly too many times
  Is locked out from their account
  
  Scenario: User submits an incorrect code too many times and is locked out
    Given I am logged in
      And I am opted-in
      And I am on the verification page
      And I enter too many invalid codes
    Then I am redirected to the locked page
      And I receive a message "Too many invalid attempts. Your account has been locked."

    Scenario: User is locked out and tries to go to the verify page
      Given I am logged in
        And I am opted-in
        And I am on the verification page
        And I enter too many invalid codes
        And I go to the gringotts settings page
      Then I am redirected to the locked page
        And I receive a message "Too many invalid attempts. Your account has been locked."