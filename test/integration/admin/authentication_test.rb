require 'test_helper'

class Admin::AuthenticationTest < ActionController::IntegrationTest

  fixtures :users

  context "At the admin environment" do

    setup do
      visit admin_login_url
    end

    context "logging in with valid username and password" do
      setup do
        fill_in "Login", :with => users(:admin).login
        fill_in "password", :with => 'monkey'
        click_button 'Log in'
      end
      should_set_the_flash_to "Logged in successfully"
    end
    
    context "logging in with invalid username and password" do
      setup do
        fill_in "Login", :with => 'root'
        fill_in "password", :with => 'badsecret'
        click_button 'Log in'
      end

      should_set_the_flash_to "Couldn't log you in as 'root'"
    end

  end

end
