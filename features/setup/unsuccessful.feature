Feature: Unsuccessful Setup
  In order to set up a new Gringotts account
  A user who submits invalid information
  Is not successfully opted-in  

  Scenario: New user opts-in but does not give phone number
      Given I am logged in
        And I do not have any gringotts settings
      When I go to the gringotts setup page
        And I click Continue
      Then I receive a message "Phone number can't be blank"
        And no settings were created
        
    Scenario: New user opts-in but gives an invalid phone number
      Given I am logged in
        And I do not have any gringotts settings
      When I go to the gringotts setup page
        And I enter the phone number "12345"
        And I click Continue
      Then I receive a message "Phone number is an invalid number"
        And no settings were created

  Scenario: User bails on setup but then wants to continue
      Given I am logged in
        And I do not have any gringotts settings
      When I go to the gringotts setup page
        And I enter the phone number "444-444-4444"
        And I click Continue
        And I click Nevermind
        And I go to the main gringotts page
      Then I should see the verify page

  @wip
  Scenario: New user gives already-used phone number and receives error
  
  @wip
  Scenario: New user gives variation on already-used phone number and receives error
