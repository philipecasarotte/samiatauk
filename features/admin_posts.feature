Feature: Manage posts
  In order to have informational posts on my site
  As an admin user
  I want to be able to manage posts and edit them like a rich text editor

  Background:
    Given I am logged in as admin
    
  Scenario: Posts list
    Given the following post records
      | name     | body          | published_on |
      | About Us | About Us post | 2009-07-06   |
      | Contact  | Contact post  | 2009-06-06   |
    When I go to the admin list of posts
    Then I should see "About Us"
    And I should see "Contact"

  Scenario: Criar valid post
    Given I have no posts
    And I am on the admin list of posts
    When I follow "Novo Post"
    And I fill in "Nome" with "About Us"
    And I fill in "post[body]" with "About Us"
    And I press "Criar"
    Then I should see "Criado com sucesso!"
    And I should see "About Us"
    And I should have 1 post

  Scenario: Criar invalid post
    Given I have no posts
    And I am on the admin list of posts
    When I follow "Novo Post"
    And I press "Criar"
    Then I should see "Nome não pode ser vazio"
    And I should have 0 posts

  Scenario: Edit a Post
  Given the following post records
    | name     | body          | published_on |
    | About Us | About Us post | 2009-07-06   |
    | Contact  | Contact post  | 2009-06-06   |
    And I am on the admin list of posts
    When I follow "Edit"
    And I fill in "Nome" with "Get in touch with us"
    And I press "Atualizar"
    Then I should see "Atualizado com sucesso!"
    And I should see "Get in touch with us" 
