require 'test_helper'

class Admin::UserSessionsControllerTest < ActionController::TestCase
  setup :activate_authlogic

  context "A user logging in" do

    context "with valid credentials" do
      setup do
        @user = Factory(:admin)
        post :create, :user_session => {:login => @user.login, :password => @user.password}
      end

      should_assign_to :user_session
      should_set_the_flash_to I18n.t(:login_message)
      should_redirect_to('the pages list') { admin_root_url }
      should "assign the user session" do
        assert user_session = UserSession.find
        assert_equal @user, user_session.user
      end
    end

    context "with invalid credentials" do
      setup do
        post :create, :user_session => {:login => "invalid_user", :password => "badpassword" }
      end

      should_not_set_the_flash
      should_respond_with :success
      should_render_template :new
    end
    
  end

  context "A user logging out" do
    setup do
      UserSession.create(Factory(:user))
      delete :destroy
    end

    should "not have a user session" do
      assert_nil UserSession.find
    end
    should_redirect_to('the login page') { admin_login_url }
  end
end
