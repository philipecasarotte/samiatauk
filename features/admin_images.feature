Feature: Manage Images
  In order to have images on my site
  As an admin user
  I want to be able to manage images and edit them

  Background:
    Given I am logged in as admin

  Scenario: Admin Images List
    Given the following photo_gallery records
	    | name     | description	        | id |
	    | About Us | About Us photo_gallery | 1  |
	    | Contact  | Contact photo_gallery  | 2  |
    And the following image records
      | name         | photo_gallery_id |
      | Images One   | 1                |
      | Images Two   | 1                |
      | Images Three | 2                |
    When I go to the admin list of images
    Then I should see "Images One"
    And I should see "Images Two"
    And I should not see "Images Three"
  
  Scenario: Create valid images
    Given the following photo_gallery records
	    | name     | description	        | id |
	    | About Us | About Us photo_gallery | 1  |
	    | Contact  | Contact photo_gallery  | 2  |
    And I have no images
    And I am on the admin list of images
    When I follow "Nova Foto"
    And I fill in "Nome" with "Images Title"
    And I press "Criar"
    Then I should see "Criado com sucesso!"
    And I should see "Images Title"
    And I should have 1 images
  
  Scenario: Create invalid images
    Given the following photo_gallery records
	    | name     | description	        | id |
	    | About Us | About Us photo_gallery | 1  |
	    | Contact  | Contact photo_gallery  | 2  |
    Given I have no images
    And I am on the admin list of images
    When I follow "Nova Foto"
    And I press "Criar"
    Then I should see "não pode ser vazio"
    And I should have 0 images
    
  Scenario: Edit images
    Given the following photo_gallery records
	    | name     | description	        | id |
	    | About Us | About Us photo_gallery | 1  |
	    | Contact  | Contact photo_gallery  | 2  |
    And the following image records
	    | name         | photo_gallery_id |
	    | Images One   | 1                |
	    | Images Two   | 1                |
	    | Images Three | 2                |
    And I am on the admin list of images
    When I follow "Editar"
    And I fill in "Nome" with "Images One Edited"
    And I press "Atualizar"
    Then I should see "Atualizado com sucesso!"
    And I should see "Images One Edited"