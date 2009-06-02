require 'test_helper'

class Admin::AuthenticationTest < ActionController::IntegrationTest

  context "At the admin environment" do

    setup do
      @user = Factory(:user)
      visit '/admin/login'
    end

    context "logging in with valid login and password and admin permissions" do
      setup do
        admin = Factory(:admin)
        fill_in "Login", :with => admin.login
        fill_in I18n.t(:password), :with => admin.password
        click_button 'Login'
      end
      
      should "show login message" do
        assert_contain I18n.t(:login_message)
      end
    end
    
    context "logging in with invalid login" do
      setup do
        fill_in "Login", :with => 'root'
        fill_in I18n.t(:password), :with => 'badsecret'
        click_button 'Login'
      end

      should "show the error for login" do
        assert_contain Authlogic::I18n.t('error_messages.login_not_found')
      end
    end
    
    context "logging in with valid login but invalid password" do
      setup do
        fill_in "Login", :with => "user1"
        fill_in I18n.t(:password), :with => "badpassword"
        click_button "Login" 
      end

      should "show the error for password" do
        assert_contain Authlogic::I18n.t('error_messages.password_invalid')
      end
    end
    
    context "logging in with valid login and password but without admin role" do

      setup do
        fill_in "Login", :with => @user.login
        fill_in I18n.t(:password), :with => @user.password
        click_button "Login"
      end

      should "show the error for authorization" do
        assert_contain I18n.t(:unauthorized)
      end

    end
    
    context "logging out" do
      setup do
        admin = Factory(:admin)
        fill_in "Login", :with => admin.login
        fill_in I18n.t(:password), :with => admin.password
        click_button 'Login'
      end

      should "show logout message" do
        click_link I18n.t(:logout)
        assert_contain I18n.t(:logout_message)
      end
    end

  end
end
