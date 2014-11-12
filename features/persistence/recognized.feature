Feature: Recognizing devices
  In order to recognize a device that a user has already verified
  We can remember devices with cookies
  
  Scenario: Anonymous user is not recognized
    Given I do not exist as a user
    When I return to the site
    Then I am not recognized
    
  Scenario: Normal user not recognized after logging in
    Given I am logged in
    When I return to the site
    Then I am not recognized

  Scenario: Normal user not recognized after logging out
    Given I am logged in
    When I sign out
    Then I am not recognized

  Scenario: Unconfirmed user not recognized while in middle of verification
    Given I need to confirm my phone number
    Then I am not recognized
 
  Scenario: Unconfirmed user not recognized after logging back in
    Given I need to confirm my phone number
    When I sign out
      And I sign in with valid credentials
    Then I am not recognized
    
  Scenario: Unconfirmed user not recognized after logging out
    Given I need to confirm my phone number
    When I sign out
    Then I am not recognized

  Scenario: Confirmed user not recognized after confirming without checking remember me
    Given I am confirmed
    When I return to the site
    Then I am not recognized
  
  Scenario: Confirmed user not recognized even after signing out without checking remember me
    Given I am confirmed
    When I sign out
    Then I am not recognized
    
  Scenario: Confirmed user not recognized even after logging back in without checking remember me
    Given I am confirmed
    When I sign out
      And I sign in with valid credentials
    Then I am not recognized

  Scenario: Confirmed user recognized after confirming and checking remember me
    Given I am confirmed with remember me
    When I return to the site
    Then I am recognized

  Scenario: Confirmed user recognized even after signing out and checking remember me
    Given I am confirmed with remember me
    When I sign out
    Then I am recognized

  Scenario: Confirmed user recognized even after logging back in and checking remember me
    Given I am confirmed with remember me
    When I sign out
      And I sign in with valid credentials
    Then I am recognized


  Scenario: User not recognized after logging back in after successful verification but not checking remember me
    Given I am logged in
      And I am opted-in
      And I am on the verification page
    When I enter the correct code
      And I receive a correct code message
      And I sign out
      And I am logged in
    Then I am not recognized
      And I am on the prompt page


  Scenario: User recognized after logging back in after successful verification and checking remember me
    Given I am logged in
      And I am opted-in
      And I am on the verification page
    When I enter the correct code and check remember me
      And I receive a correct code message
      And I sign out
      And I am logged in
    Then I am recognized
      And I see a successful sign in message

@wip
Scenario: User verifies with "remember me" but a different user logging in needing 2FA will still be prompted
