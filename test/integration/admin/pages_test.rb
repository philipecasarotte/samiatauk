require 'test_helper'

class Admin::PagesTest < ActionController::IntegrationTest

  def setup
    admin_is_logged_in
  end

  context "Given I have pages named About, Contact" do
    setup do
      Factory.create(:page, :name => 'About')
      Factory.create(:page, :name => 'Contact')
      visit '/admin/pages'
    end

    should "get the list of pages" do
      assert_contain 'About'
      assert_contain 'Contact'
    end
  end
  
  context "Creating a valid page" do
    setup do
      visit 'admin/pages'
      click_link I18n.t(:new_page)
      fill_in I18n.t(:name, :scope => 'activerecord.attributes._all'), :with => 'Terms of Use'
      click_button I18n.t(:create)
    end

    should "add the page to the list" do
      assert_contain I18n.t(:success_create)
      assert_contain 'Terms of Use'
    end
    
    should_change "Page.count", :by => 1
  end
  
  context "Editing a page" do
    
    setup do
      @page = Factory.create(:page, :name => 'About the company')
      visit 'admin/pages'
      
      click_link_within "#page_#{@page.id} > div", I18n.t(:edit)
      fill_in I18n.t(:name, :scope => 'activerecord.attributes._all'), :with => "About Us"
      click_button I18n.t(:update)
    end

    should "edit the right page" do
      assert_contain "About Us"
    end
  end

end
