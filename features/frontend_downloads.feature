Feature: Frontend downloads
  In order to see informational downloads
  As an user
  I want to be able to navigate through the site
  
  Background: 
    Given the following download records
	    | name     | description       | subject     |
	    | Estudo 1 | About Us download | Evangelismo |
	    | Estudo 2 | Contact download  | Ciência     |
	And the following page records
		| name        | body          | permalink   |
	    | Home        | Home Page     | home        |
		| Ciência     | Lorem sit     | ciencia     |
		| Evangelismo | Amet dolem    | evangelismo |
      
  Scenario: Visit the list of downloads for science
    When I go to the homepage
    And I follow "CIÊNCIA"
    Then I should see "Estudo 2"
    And I should not see "Estudo 1"

  Scenario: Visit the list of downloads for faith
    When I go to the homepage
    And I follow "EVANGELISMO"
    Then I should see "Estudo 1"
    And I should not see "Estudo 2"
    
  Scenario: Visit a download
    When I go to the homepage
    And I follow "EVANGELISMO"
    And I follow "Estudo 1"
    Then I should see "Estudo 1"
	And I should see "About Us download"
