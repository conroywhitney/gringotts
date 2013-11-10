Feature: Editing Settings
  In order to allow users to change their Gringotts settings
  A user who has already opted-in
  Should be able to change their Gringotts settings

  Scenario: Confirmed user sees success page when goes to settings
    Given I am confirmed
    When I go to the main gringotts page
    Then I am redirected to the success page

  Scenario: Confirmed user sees link to change phone number
    Given I am confirmed
    When I go to the main gringotts page
    Then I receive a message "Change phone number"

  @wip
  Scenario: User who edits their phone number is no longer opted-in
    Given I am confirmed
    When I go to the gringotts setup page
      And I enter the phone number "(406) 555-5555"
      And I click Continue
    Then I should see the verify page
    When I navigate to a protected page
    Then I should see the verify page

  @wip
  Scenario: User who edits phone number and re-confirms is confirmed
