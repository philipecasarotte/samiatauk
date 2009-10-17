Feature: Manage users
  In order to control who has access to the admin section
  As an admin user
  I want to be able to manage users and assign them roles

  Background:
    Given I am logged in as admin

  Scenario: Admin Users List
    Given the following user records
      | login | email             | password | password_confirmation |
      | bob   | bob@example.com   | secret   | secret                |
      | admin | admin@example.com | secret   | secret                |
    And the following role records
      | name  |
      | admin |
    And the user "bob" has no role
    And the user "admin" has a role "admin"
    When I go to the admin list of admin users
    Then I should see "admin"
    And I should see "admin@example.com"
    And I should not see "bob@example.com"

  Scenario: Regular Users List
    Given the following user records
      | login | email             | password | password_confirmation |
      | bob   | bob@example.com   | secret   | secret                |
      | admin | admin@example.com | secret   | secret                |
    And the following role records
      | name  |
      | admin |
    And the user "bob" has no role
    And the user "admin" has a role "admin"
    When I go to the admin list of users
    Then I should see "bob"
    And I should see "bob@example.com"
    And I should see "admin"
    And I should see "admin@example.com"

  Scenario: Criar Valid User
    Given I have no users except for admin
    And the following role records
      | name  |
      | admin |
    And I am on the admin list of users
    When I follow "Novo Usuário"
    And I fill in "Login" with "bob"
    And I fill in "Nome" with "Bob"
    And I fill in "Senha" with "secret"
    And I fill in "Confirmação de senha" with "secret"
    And I fill in "Email" with "bob@example.com"
    And I check the role "Admin"
    And I press "Criar"
    Then I should see "Criado com sucesso!"
    And I should see "bob"
    And I should have 2 users

  Scenario: Criar Invalid User
    Given I have no users except for admin
    And the following role records
      | name  |
      | admin |
    And I am on the admin list of users
    When I follow "Novo Usuário"
    And I fill in "Nome" with "Bob"
    And I fill in "Senha" with "secret"
    And I fill in "Confirmação de senha" with "secret"
    And I fill in "Email" with "bob@example.com"
    And I check the role "Admin"
    And I press "Criar"
    Then I should see "Login é muito curto"
    And I should not see "bob"
    And I should have 1 user

  Scenario: Edit a User
    Given the following user records
      | login | email             | password | password_confirmation |
      | bob   | bob@example.com   | secret   | secret                |
      | admin | admin@example.com | secret   | secret                |
    And I am on the admin list of users
    When I follow "Edit"
    And I fill in "Nome" with "Bob Martin"
    And I press "Atualizar"
    Then I should see "Atualizado com sucesso!"
    And I should see "Bob Martin"