Feature: Confirmed User
  In order to verify who they say they are
  A confirmed user needs to enter the received code
  And continues when enters correct code

  Scenario: Confirmed user does not see "nevermind" message because must verify
    Given I am confirmed
    When I go to verify
    Then I should not see "Nevermind, I'll do this later"     
  
  Scenario: User does not see full phone number
    Given I am confirmed
    When I go to verify
    Then I do not see my phone number
    
  Scenario: User sees only last 4 digits of phone number
    Given I am confirmed
    When I go to verify
    Then I see the last 4 digits of my phone number
