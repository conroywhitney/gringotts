Feature: Verifying
  In order to verify access to an account
  An existing user is prompted for a code
  And must enter that code to continue
  
    Scenario: User must have opted-in first
      Given I am logged in
        But I am not opted-in
      When I am on the verification page
      Then I am redirected to the settings page
    
    Scenario: User sees verification form
      Given I am logged in
        And I am opted-in
      When I am on the verification page
      Then I see the verification form
      
    Scenario: [Temporary] User sees a code to enter
      Given I am logged in
        And I am opted-in
      When I am on the verification page
      Then I see the expected verification code
      
    Scenario: User submits a blank code
      Given I am logged in
        And I am opted-in
      When I am on the verification page
        And I enter a blank code
        And I press submit
      Then I receive a message "Code is required"
      
    Scenario: User submits an invalid code
      Given I am logged in
        And I am opted-in
      When I am on the verification page
        And I enter the code "asdf"
        And I press submit
      Then I receive a message "Invalid code"
      
    Scenario: User submits a previous code
    
    Scenario: User submits an expired code
    
    Scenario: User submits the correct code
    
