Feature: First-Time User Declines
  In order to not annoy users
  A user is shown the opt-in option once
  But can decline and is not shown the option again
  
  Scenario: User who has already seen opt-in but declined does not see twice
    Given I exist as a user
      And I am not logged in
    When I sign in with valid credentials
    Then I should see the opt-in prompt
    When I decline opting in    
     And I sign out
     And I sign in with valid credentials
    Then I should not see the opt-in prompt
    
  Scenario: User who declines to opt-in continues
    Given I exist as a user
      And I am not logged in
    When I sign in with valid credentials
      And I should see the opt-in prompt
      And I decline opting in
    Then I should be signed in
