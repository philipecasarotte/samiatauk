Feature: Manage downloads
  In order to have informational downloads on my site
  As an admin user
  I want to be able to manage downloads and edit them like a rich text editor

  Background:
    Given I am logged in as admin
    
  Scenario: Downloads list
    Given the following download records
      | name     | description       | subject     |
      | About Us | About Us download | Evangelismo |
      | Contact  | Contact download  | Ciência     |
    When I go to the admin list of downloads
    Then I should see "About Us"
    And I should see "Contact"

  Scenario: Criar valid download
    Given I have no downloads
    And I am on the admin list of downloads
    When I follow "Novo Download"
    And I fill in "Nome" with "About Us"
    And I fill in "download[description]" with "About Us"
    And I press "Criar"
    Then I should see "Criado com sucesso!"
    And I should see "About Us"
    And I should have 1 download

  Scenario: Criar invalid download
    Given I have no downloads
    And I am on the admin list of downloads
    When I follow "Novo Download"
    And I press "Criar"
    Then I should see "Nome não pode ser vazio"
    And I should have 0 downloads

  Scenario: Edit a  
    Given the following download records
	    | name     | description       | subject     |
	    | About Us | About Us download | Evangelismo |
	    | Contact  | Contact download  | Ciência     |
    And I am on the admin list of downloads
    When I follow "Edit"
    And I fill in "Nome" with "Get in touch with us"
    And I press "Atualizar"
    Then I should see "Atualizado com sucesso!"
    And I should see "Get in touch with us"

  Scenario: Reorder Downloads
    Given the following download records
    | name     | description       | subject     | position |
    | About Us | About Us download | Evangelismo | 1        |
    | Contact  | Contact download  | Ciência     | 0        |
    And I go to the admin list of downloads
    When I follow "Reordenar"
    Then I should see "About Us"
    And I should see "Contact"
  
