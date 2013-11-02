Feature: Anonymous User is not Hijacked
  In order to preserve normal behaviour of site
  An anonymous user is not prompted for Gringotts 2FA
  And can continue using the site in the normal way
  
  Scenario: Anonymous user can view un-protected pages
    Given I do not exist as a user
    When I navigate to an un-protected page
    Then I should not see the verify page
  
  Scenario: Anonymous user is prompted to sign to view protected pages
    Given I do not exist as a user
    When I navigate to a protected page
    Then I should not see the verify page
      But I should be asked to sign in
