Feature: Editing Settings
  In order to allow users to change their Gringotts settings
  A user who has already opted-in
  Should be able to change their Gringotts settings

  @wip
  Scenario: User who edits their phone number is no longer opted-in
    Given I am confirmed
    When I go to the gringotts settings page
      And I edit my phone number
    Then I am no longer confirmed

  @wip
  Scenario: User who edits phone number and re-confirms is confirmed
