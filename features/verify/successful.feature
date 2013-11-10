Feature: Successful
  In order to verify access to an account
  An existing user is prompted for a code
  And continues when enters correct code
  
    Scenario: User must have opted-in first
      Given I am logged in
        But I am not opted-in
      When I go to the verification page
      Then I am redirected to the settings page
    
    Scenario: User sees verification form
      Given I am logged in
        And I am opted-in
        And I am on the verification page
      Then I see the verification form

    Scenario: First-time user clicks on "nevermind" link and is still signed in
      Given I am logged in
        And I am opted-in
        And I am on the verification page
      When I click "Nevermind, I'll do this later"
      Then I should be signed in
        And I do not see the verification form
      
    Scenario: Opted-in user does not see "nevermind" message because must verify
      Given I am confirmed
        But I am not logged in
      When I sign in with valid credentials
      Then I should see the verify page
       But I should not see "Nevermind, I'll do this later"     
      
    Scenario: [Temporary] User sees a code to enter
      Given I am logged in
        And I am opted-in
        And I am on the verification page
      Then (Temporarily) I see the expected verification code
    
    Scenario: User submits the correct code
      Given I am logged in
        And I am opted-in
        And I am on the verification page
      When I enter the correct code
      Then I am redirected to the success page
        And my valid attempt was logged
        And I receive a correct code message
