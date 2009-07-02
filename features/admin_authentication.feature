Feature: Authentication
  In order to get access to the admin and protect from unauthorized access
  As an admin user
  I want to be able to sign in and sign out

    Scenario: User is not signed up
      Given no user exists with a login of "someuser"
      When I go to the login page
      And I sign in as "someuser/password"
      Then I should see "login is not valid"

   Scenario: User enters wrong password
      Given I signed up with "someuser/password"
      When I go to the login page
      And I sign in as "someuser/wrongpassword"
      Then I should see "password is not valid"
   
   Scenario: User signs in with valid login and password but without admin role
      Given I signed up with "someuser/secret"
      When I go to the login page
      And I sign in as "someuser/secret"
      Then I should see "You don't have access here"

    Scenario: User signs in with valid login and password and admin role
       Given I am signed up with "someuser/secret" as "admin"
       When I go to the login page
       And I sign in as "someuser/secret"
       Then I should see "Logged in successfully"

    Scenario: User signs out
      Given I am signed up with "someuser/secret" as "admin"
      When I go to the login page
      And I sign in as "someuser/secret"
      And I sign out
      Then I should see "You have been logged out"     
