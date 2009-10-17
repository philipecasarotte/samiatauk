Feature: Frontend posts
  In order to see informational posts
  As an user
  I want to be able to navigate through the site
  
  Background: 
    Given the following post records
	    | name     | body          | published_on | id |
	    | Post 1   | About Us post | 2009-07-06   | 1  |
	    | Post 2   | Contact post  | 2009-06-06   | 2  |
	And the following page records
		| name        | body          | permalink   |
	    | Home        | Home Page     | home        |
		| Blog        | Lorem sit     | ciencia     |
	And the following comment records
	    | name           | email            | website               | comment | post_id |
	    | Comments One   | phil@test.com.br | http://www.uol.com.br | Wow!    | 1       |
	    | Comments Two   | drag@test.com.br |                       | Uau!    | 1       |
      
  Scenario: Visit the list of posts
    When I go to the homepage
    And I follow "BLOG"
    Then I should see "Post 1"
    And I should see "Post 2"

  Scenario: Visit a posts with comments
    When I go to the homepage
    And I follow "BLOG"
    And I follow "POST 1"
    Then I should see "Post 1"
    And I should see "About Us post"
	And I should see "Comentários"
	And I should see "Wow!"
	And I should see "Uau!"

  Scenario: Visit a post without comments
    When I go to the homepage
    And I follow "BLOG"
    And I follow "POST 2"
    Then I should see "Post 2"
	And I should see "Contact post"
	And I should see "Nenhum Comentário ainda"