require 'test_helper'
require 'admin/pages_controller'

class Admin::PagesController; def rescue_action(e) raise e end; end

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
      assert_equal 2, assigns(:pages).size
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
      put :update, :id => pages(:home).id, :page => { :title=>"Testing" }
      assert_redirected_to admin_pages_path
      assert_equal "testing", assigns(:page).permalink
    end
  
    should "delete a page" do
      assert_difference "Page.count", -1 do
        delete :destroy, :id => pages(:home).id
        assert_redirected_to admin_pages_path
      end
    end
    
  end
  
  # context "At Admin environment with children" do
  #   setup do
  #     @controller = Admin::PagesController.new
  #     @request    = ActionController::TestRequest.new
  #     @response   = ActionController::TestResponse.new
  #     login_as(:admin)
  #   end
  #   
  #   should "give all children" do
  #     get :index, :parent_id=>pages(:about).id
  #     assert_kind_of Array, assigns(:pages)
  #     assert_equal 1, assigns(:pages).size
  #   end
  #   
  #   should "create a child" do
  #     post :create, :page => { :title => "A Child of About", :body=> "Testing the about!", :parent_id=>pages(:about).id }
  #     assert_redirected_to admin_pages_path(:parent_id=>pages(:about).id)
  #     get :index, :parent_id=>pages(:about).id
  #     assert_equal 2, assigns(:pages).size
  #   end
  #   
  #   should "update a child" do
  #     put :update, :id => pages(:about_child).id, :page => { :title => "Uhuu!", :parent_id=>pages(:about).id }
  #     assert_redirected_to admin_pages_path(:parent_id=>pages(:about).id)
  #   end
  #   
  #   should "destroy a child" do
  #     delete :destroy, :id=>pages(:about_child).id
  #     assert_redirected_to admin_pages_path(:parent_id=>pages(:about).id)
  #   end
  # end
end
