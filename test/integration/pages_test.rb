require 'test_helper'

class PagesTest < ActionController::IntegrationTest

  context "Given that I have an About Page, a Contact Page and a Home Page" do
    setup do
      Factory(:page)
      Factory(:about)
      Factory(:page, :name => 'Contact')
    end

    should "show the name of the page" do
      visit '/pages/home'
      assert_contain 'Home'
    end

    should "show the name of the page with more than 1 word" do
      visit '/pages/about-us'
      assert_contain 'About Us'
    end
    
    should "show the title of Contact page and the form" do
      visit '/pages/contact'
      assert_contain 'Contact'
      assert_have_selector 'form', {:action => page_path('contact')}
    end
  end
  
end
