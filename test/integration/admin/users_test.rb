require 'test_helper'

class Admin::UsersTest < ActionController::IntegrationTest

  def setup
    admin_is_logged_in
  end

  context "Given I have users named Bob, Carrie" do
    setup do
      Factory.create(:user, :name => 'Bob', :login => Factory.next(:login), :email => Factory.next(:email))
      Factory.create(:user, :name => 'Carrie', :login => Factory.next(:login), :email => Factory.next(:email))
      visit '/admin/users'
    end

    should "get the list of users" do
      assert_contain 'Bob'
      assert_contain 'Carrie'
    end
  end
  
  context "Creating a normal user" do
    setup do
      visit 'admin/users'
      click_link 'New User'
      fill_in "Login", :with => 'danieltburns'
      fill_in "Name", :with => 'Daniel'
      fill_in "Email", :with => 'burns@example.com'
      fill_in "Password", :with => 'bundinha'
      fill_in "Password Confirmation", :with => 'bundinha'  
      click_button I18n.t(:create)
    end

    should "add the user to the list" do
      assert_contain 'Successfully created'
      assert_contain 'danieltburns'
    end
    
    should_change "User.count", :by => 1
  end

  context "Creating an admin user" do
    setup do
      role = Factory(:admin_role)
      visit 'admin/users'
      click_link 'New User'
      fill_in "Login", :with => 'danieltburns'
      fill_in "Name", :with => 'Daniel'
      fill_in "Email", :with => 'burns@example.com'
      fill_in "Password", :with => 'bundinha'
      fill_in "Password Confirmation", :with => 'bundinha'
      check "role_#{role.id}"
      click_button I18n.t(:create)
      click_link I18n.t(:menu_admins)
    end

    should "add the user to the admin list" do
      assert_contain "Listing Admin Users"
      assert_contain 'danieltburns'
    end
  end

  
  context "Editing a user" do
    
    setup do
      @user = Factory.create(:user, :name => 'Daniel Burns')
      visit 'admin/users'
      
      click_link I18n.t(:edit)
      fill_in "Name", :with => "Daniel T Burns"
      click_button I18n.t(:update)
    end

    should "edit the right user" do
      assert_contain "Daniel T Burns"
    end
  end
end
