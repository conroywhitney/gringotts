Feature: Locking
  In order to verify access to an account
  A user who has tried to log in incorrectly too many times
  Is locked out from their account
  
  Scenario: First-time user can never be locked out of account while trying to confirm
    Given I am logged in
      And I am opted-in
      And I am on the verification page
    When I enter too many invalid codes
    Then I am on the verification page
      And my account is not locked    
    When I enter too many invalid codes
    Then I am on the verification page
      And my account is not locked
      
  Scenario: User submits an incorrect code too many times and is locked out
    Given I am confirmed
      But I am not logged in
    When I sign in with valid credentials
      And I enter too many invalid codes
    Then I am redirected to the locked page
      And my account is locked
      And I receive a message "Too many invalid attempts. Your account has been locked."

  Scenario: User is locked out and tries to go to the main gringotts page
    Given I am locked out
    When I go to the main gringotts page
    Then I am redirected to the locked page
      And I receive a message "Too many invalid attempts. Your account has been locked."

  Scenario: User is locked out and tries to go to the setup page
    Given I am locked out
    When I go to the gringotts setup page
    Then I am redirected to the locked page
      And I receive a message "Too many invalid attempts. Your account has been locked."
      
  Scenario: User is locked out and tries to go to the verify page
    Given I am locked out
    When I go to the verification page
    Then I am redirected to the locked page
      And I receive a message "Too many invalid attempts. Your account has been locked."
      
  Scenario: User is locked out and tries to go to an un-protected page
    Given I am locked out
    When I navigate to an un-protected page
    Then I am redirected to the locked page
      And I receive a message "Too many invalid attempts. Your account has been locked."

  Scenario: User is locked out and tries to go to a protected page
    Given I am locked out
      And I navigate to a protected page
    Then I am redirected to the locked page
      And I receive a message "Too many invalid attempts. Your account has been locked."
        
        