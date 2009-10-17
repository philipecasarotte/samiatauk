Feature: Manage Comments
  In order to have comments on my site
  As an admin user
  I want to be able to manage comments and edit them

  Background:
    Given I am logged in as admin

  Scenario: Admin Comments List
    Given the following post records
	    | name     | body	          | id |
	    | About Us | About Us comment | 1  |
	    | Contact  | Contact comment  | 2  |
    And the following comment records
	    | name           | email            | website               | comment | post_id |
	    | Comments One   | phil@test.com.br | http://www.uol.com.br | Wow!    | 1       |
	    | Comments Two   | drag@test.com.br |                       | Uau!    | 1       |
	    | Comments Three | phil@test.com.br | http://www.uol.com.br | Legal!  | 2       |
    When I go to the admin list of comments
    Then I should see "Comments One"
    And I should see "Comments Two"
    And I should not see "Comments Three"
  
  Scenario: Create valid comments
    Given the following post records
	    | name     | body        	  | id |
	    | About Us | About Us comment | 1  |
	    | Contact  | Contact comment  | 2  |
    And I have no comments
    And I am on the admin list of comments
    When I follow "Novo Comentário"
    And I fill in "Nome" with "Comments Title"
	And I fill in "Email" with "tit@tot.com"
	And I fill in "comment[comment]" with "Comments Wow!"
    And I press "Criar"
    Then I should see "Criado com sucesso!"
    And I should see "Comments Title"
    And I should have 1 comments
  
  Scenario: Create invalid comments
    Given the following post records
	    | name     | body             | id |
	    | About Us | About Us comment | 1  |
	    | Contact  | Contact comment  | 2  |
    Given I have no comments
    And I am on the admin list of comments
    When I follow "Novo Comentário"
    And I press "Criar"
    Then I should see "não pode ser vazio"
    And I should have 0 comments
    
  Scenario: Edit comments
    Given the following post records
	    | name     | body             | id |
	    | About Us | About Us comment | 1  |
	    | Contact  | Contact comment  | 2  |
    And the following comment records
	    | name           | email            | website               | comment | post_id |
	    | Comments One   | phil@test.com.br | http://www.uol.com.br | Wow!    | 1       |
	    | Comments Two   | drag@test.com.br |                       | Uau!    | 1       |
	    | Comments Three | phil@test.com.br | http://www.uol.com.br | Legal!  | 2       |
    And I am on the admin list of comments
    When I follow "Editar"
    And I fill in "Nome" with "Comments One Edited"
    And I press "Atualizar"
    Then I should see "Atualizado com sucesso!"
    And I should see "Comments One Edited"