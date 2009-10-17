Feature: Frontend photo galleries
  In order to see informational photo galleries
  As an user
  I want to be able to navigate through the site
  
  Background: 
    Given the following photo_gallery records
	    | name        | description            | id | position |
	    | Gallery 1   | About Us photo gallery | 1  | 0        |
	    | Gallery 2   | Contact photo gallery  | 2  | 1        |
	And the following page records
		| name        | body           | permalink   |
	    | Home        | Home Page      | home        |
		| Fotos        | Lorem sit     | fotos       |
	And the following image records
	    | name        | photo_gallery_id | image_file_name |
	    | Image One   | 1                | tit.jpg         |
	    | Image Two   | 2                | tot.jpg         |
      
  Scenario: Visit the list of photo galleries
    When I go to the homepage
    And I follow "FOTOS"
    Then I should see "Gallery 1"
	And I should see "About Us photo gallery"
    And I should not see "Contact photo gallery"

  Scenario: Visit a photo galleries with images
    When I go to the homepage
    And I follow "FOTOS"
    Then I should see "Gallery 1"
    And I should see "About Us photo gallery"
	And I should see "Image One"
	And I should see "tit.jpg"
	And I should not see "Image Two"