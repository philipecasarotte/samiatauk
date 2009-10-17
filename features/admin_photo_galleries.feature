Feature: Manage photo galleries
  In order to have informational photo galleries on my site
  As an admin user
  I want to be able to manage photo galleries and edit them

  Background:
    Given I am logged in as admin
    
  Scenario: Photo Galleries list
    Given the following photo_gallery records
      | name     | description	          |
      | About Us | About Us photo_gallery |
      | Contact  | Contact photo_gallery  |
    When I go to the admin list of photo galleries
    Then I should see "About Us"
    And I should see "Contact"

  Scenario: Criar valid photo_gallery
    Given I have no photo galleries
    And I am on the admin list of photo galleries
    When I follow "Nova Galeria"
    And I fill in "Nome" with "About Us"
    And I fill in "photo_gallery[description]" with "About Us"
    And I press "Criar"
    Then I should see "Criado com sucesso!"
    And I should see "About Us"
    And I should have 1 photo gallery

  Scenario: Criar invalid photo_gallery
    Given I have no photo galleries
    And I am on the admin list of photo galleries
    When I follow "Nova Galeria"
    And I press "Criar"
    Then I should see "Nome não pode ser vazio"
    And I should have 0 photo galleries

  Scenario: Edit a Photo Gallery
  Given the following photo_gallery records
    | name     | description            |
    | About Us | About Us photo_gallery |
    | Contact  | Contact photo_gallery  |
    And I am on the admin list of photo galleries
    When I follow "Edit"
    And I fill in "Nome" with "Get in touch with us"
    And I press "Atualizar"
    Then I should see "Atualizado com sucesso!"
    And I should see "Get in touch with us" 
