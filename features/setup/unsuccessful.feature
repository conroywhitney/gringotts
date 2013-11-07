Feature: Unsuccessful Setup
  In order to set up a new Gringotts account
  A user who submits invalid information
  Is not successfully opted-in  

  Scenario: New user opts-in but does not give phone number
      Given I am logged in
        And I do not have any gringotts settings
      When I go to the gringotts settings page
        And I check the opt-in box
        And I click Continue
      Then I receive a message "Phone number can't be blank"
        And no settings were created
        
    Scenario: New user opts-in but gives an invalid phone number
      Given I am logged in
        And I do not have any gringotts settings
      When I go to the gringotts settings page
        And I check the opt-in box
        And I enter the phone number "12345"
        And I click Continue
      Then I receive a message "Phone number is an invalid number"
        And no settings were created
      
  @wip
  Scenario: New user gives already-used phone number and receives error
  
  @wip
  Scenario: New user gives variation on already-used phone number and receives error
