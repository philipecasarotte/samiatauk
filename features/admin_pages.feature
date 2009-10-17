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

  Scenario: Criar valid page
    Given I have no pages
    And I am on the admin list of pages
    When I follow "Nova Página"
    And I fill in "Nome" with "About Us"
    And I press "Criar"
    Then I should see "Criado com sucesso!"
    And I should see "About Us"
    And I should have 1 page

  Scenario: Criar invalid page
    Given I have no pages
    And I am on the admin list of pages
    When I follow "Nova Página"
    And I press "Criar"
    Then I should see "Nome não pode ser vazio"
    And I should have 0 pages

  Scenario: Edit a Page
    Given the following page records
      | name     | body          |
      | About Us | About Us page |
      | Contact  | Contact page  |
    And I am on the admin list of pages
    When I follow "Edit"
    And I fill in "Nome" with "Get in touch with us"
    And I press "Atualizar"
    Then I should see "Atualizado com sucesso!"
    And I should see "Get in touch with us"

  Scenario: Reorder Pages
    Given the following page records
      | name     | body          | position |
      | About Us | About Us page | 0        |
      | Contact  | Contact page  | 1        |
    And I go to the admin list of pages
    When I follow "Reordenar"
    Then I should see "About Us"
    And I should see "Contact"
  
