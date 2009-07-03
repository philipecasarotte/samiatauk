Feature: Manage pages
  In order to have informational pages on my site
  As an admin user
  I want to be able to manage pages and edit them like a rich text editor

  Background:
    Given I am logged in as admin
    
  Scenario: Pages list
    Given the following page records
      | name     | body          |
      | About Us | About Us page |
      | Contact  | Contact page  |
    When I go to the admin list of pages
    Then I should see "About Us"
    And I should see "Contact"

  Scenario: Create valid page
    Given I have no pages
    And I am on the admin list of pages
    When I follow "New Page"
    And I fill in "Name" with "About Us"
    And I press "Create"
    Then I should see "Successfully created!"
    And I should see "About Us"
    And I should have 1 page

  Scenario: Create invalid page
    Given I have no pages
    And I am on the admin list of pages
    When I follow "New Page"
    And I press "Create"
    Then I should see "Name can't be blank"
    And I should have 0 pages

  Scenario: Edit a Page
    Given the following page records
      | name     | body          |
      | About Us | About Us page |
      | Contact  | Contact page  |
    And I am on the admin list of pages
    When I follow "Edit"
    And I fill in "Name" with "Get in touch with us"
    And I press "Update"
    Then I should see "Successfully updated!"
    And I should see "Get in touch with us"

  Scenario: Reorder Pages
    Given the following page records
      | name     | body          | position |
      | About Us | About Us page | 0        |
      | Contact  | Contact page  | 1        |
    And I go to the admin list of pages
    When I follow "Reorder"
    Then I should see "About Us"
    And I should see "Contact"
  
