Feature: Frontend pages
  In order to see informational pages
  As an user
  I want to be able to navigate through the site
  
  Background: 
    Given the following page records
      | name     | body          |
      | About Us | About Us page |
      | Home     | Home Page     |
      | Contato  | Contact page  |
      
  Scenario: Visit one page
    When I go to the Home page
    Then I should see "Home"
    
  Scenario: Visit a page which name has two words
    When I go to the About Us page
    Then I should see "About Us"
    
  Scenario: Visit a page with a form
    When I go to the Contact page
    Then I should see "Contato"
    And I should see a contact form