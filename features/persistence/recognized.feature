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

  Scenario: Confirmed user recognized after confirming
    Given I am confirmed
    When I return to the site
    Then I am recognized
  
  Scenario: Confirmed user recognized even after signing out
    Given I am confirmed
    When I sign out
    Then I am recognized
    
  Scenario: Confirmed user recognized even after logging back in
    Given I am confirmed
    When I sign out
      And I sign in with valid credentials
    Then I am recognized