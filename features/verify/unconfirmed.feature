Feature: Unconfirmed User
  In order to confirm their phone number
  An existing user needs to enter the received code
  And continues when enters correct code

  Scenario: Unconfirmed user clicks on "nevermind" link and is still signed in
    Given I need to confirm my phone number
    When I click "Nevermind, I'll do this later"
    Then I should be signed in
      And I do not see the verification form

  Scenario: Unconfirmed user should jump back to confirming phone number
    Given I need to confirm my phone number
    When I click "Nevermind, I'll do this later"
      And I go to the main gringotts page
    Then I see the verification form

  Scenario: Unconfirmed user should see full phone number
    Given I need to confirm my phone number
    Then I should see my phone number
