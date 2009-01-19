require 'test_helper'
require 'admin/pages_controller'

class Admin::PagesControllerTest < ActionController::TestCase

  context "A user" do
    
    context "not logged in" do
      setup do
        logged_in = false
        get :index
      end

      should_respond_with :redirect
    end
    
    context "logged in but not authorized" do
      setup do
        login_as(:quentin)
        get :index
      end

      should_respond_with :redirect
    end
  end

  context "At the Admin environment" do 
    
    setup do
      @controller = Admin::PagesController.new
      @request    = ActionController::TestRequest.new
      @response   = ActionController::TestResponse.new
      login_as(:admin)
    end

    should "get index" do
      get :index
      assert_response :success
      assert_equal 6, assigns(:pages).size
    end

    should "get new" do
      get :new
      assert_response :success
    end
  
    should "create a page" do
      assert_difference "Page.count", 1 do
        post :create, :page => { :title=>"Test", :body=>"Testing!" }
        assert_redirected_to admin_pages_path
      end
    end

    should "show page" do
      get :show, :id => pages(:home).id
      assert_response :success
    end

    should "get page" do
      get :edit, :id => pages(:home).id
      assert_response :success
    end
  
    should "update a page" do
      put :update, :id => pages(:home).id, :page => { :title=>"Testing Again" }
      assert_redirected_to admin_pages_path
      assert_equal "testing-again", assigns(:page).slug.name
    end
  
    should "delete a page" do
      assert_difference "Page.count", -1 do
        delete :destroy, :id => pages(:home).id
        assert_redirected_to admin_pages_path
      end
    end
    
  end

end
