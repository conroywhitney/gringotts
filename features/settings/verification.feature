Feature: Verifying
  In order to verify access to an account
  An existing user is prompted for a code
  And must enter that code to continue
  
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
      
    Scenario: [Temporary] User sees a code to enter
      Given I am logged in
        And I am opted-in
        And I am on the verification page
      Then (Temporarily) I see the expected verification code
      
    Scenario: User submits a blank code
      Given I am logged in
        And I am opted-in
        And I am on the verification page
      When I enter a blank code
        And I press submit
      Then I receive a message "Code received can't be blank"
        And my blank attempt was not logged
      
    Scenario: User submits an invalid code
      Given I am logged in
        And I am opted-in
        And I am on the verification page
      When I enter the code "asdf"
        And I press submit
      Then I receive a message "Invalid code"
        And my invalid attempt was logged
        And (Temporarily) I see the expected verification code
    
    Scenario: User submits the correct code
      Given I am logged in
        And I am opted-in
        And I am on the verification page
      When I enter the correct code
        And I press submit
      Then I am redirected to the success page
        And my valid attempt was logged
        And I receive a message "Successfully Validated!"
    
