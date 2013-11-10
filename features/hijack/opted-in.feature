Feature: Opted-in User Needs to Verify
  In order to protect a user's account
  A user who has opted-in to Gringotts 2FA
  Must verify using 2FA in order to function as their logged in account
  
  Scenario: Opted-in user logging in from unknown device is required to authenticate
    Given I am confirmed
      But I am not logged in
    When I sign in with valid credentials
    Then I should see the verify page
  
  Scenario: Opted-in user tries to navigate away to a protected page is redirected back
    Given I am confirmed
      But I am not logged in
    When I sign in with valid credentials
    Then I should see the verify page
    When I navigate to a protected page
    Then I should see the verify page

  Scenario: Confirmed but unverified user cannot see edit page
    Given I am confirmed
      But I am not logged in
    When I sign in with valid credentials
      And I go to the gringotts setup page
    Then I should see the verify page
      
  Scenario: Opted-in user tries to navigate away to an un-protected page is redirected back
    Given I am confirmed
      But I am not logged in
    When I sign in with valid credentials
    Then I should see the verify page
    When I navigate to an un-protected page
    Then I should see the verify page
  
  @wip  
  Scenario: Opted-in user logging in from known device is not required to verify
    Given I am confirmed
      But I am not logged in
    When I sign in with valid credentials
    Then I should not see the verify page
    
  Scenario: Opted-in user who verifies is not bothered anymore
    Given I am confirmed
    When I navigate to a protected page
    Then I should not see the verify page
