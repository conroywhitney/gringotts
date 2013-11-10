Feature: Opting-Out
  In order to allow users to opt-out of Gringotts 2FA
  A user who has already opted-in
  Should be able to opt-out
  
  Scenario: Opted-in user should see opt-out link
    Given I am confirmed
    When I go to the main gringotts page
    Then I should see button "Turn off mobile authentication"

  Scenario: Opted-in user who clicks opt-out link is opted-out
    Given I am confirmed
    When I go to the main gringotts page
      And I click button "Turn off mobile authentication"
    Then I am redirected to the setup page
      And I should see "Phone Verification is OFF"
  
  @wip
  Scenario: Previously opted-in user who opts-out does not see prompt
  
  @wip
  Scenario: Previously opted-in user who opts-out is not required to verify