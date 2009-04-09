require File.dirname(__FILE__) + '/../../test_helper'
require 'admin/admin_controller'

class Admin::AdminControllerTest < ActionController::TestCase

  def setup
    @controller = Admin::PagesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  context "A user" do
    
    context "not logged in" do
      setup do
        logged_in = false
        get :index
      end

      should_set_the_flash_to "You are not authorized"
      should_redirect_to('login page') { admin_login_path }
    end
    
    context "logged in but not authorized" do
      setup do
        login_as(:quentin)
        get :index
      end

      should_set_the_flash_to "You are not authorized"
      should_redirect_to('login page') { admin_login_path }
    end
  end

end
