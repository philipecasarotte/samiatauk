require File.dirname(__FILE__) + '/../test_helper'
require 'pages_controller'

# Re-raise errors caught by the controller.
class PagesController; def rescue_action(e) raise e end; end

class PagesControllerTest < Test::Unit::TestCase
  
  context "Page controller" do
  
    setup do
      @controller = PagesController.new
      @request    = ActionController::TestRequest.new
      @response   = ActionController::TestResponse.new
    end
  
    should "get index" do
      get :index
      assert assigns(:pages)
      assert_equal 2, assigns(:pages).size
    end
    
    should "get show" do
      get :show, :id=>pages(:home).permalink
      assert assigns(:page)
    end
  
    should "not get destructive actions" do
      assert_raise(ActionController::UnknownAction) { post :create }
      assert_raise(ActionController::UnknownAction) { post :update, :id=>pages(:home) }
      assert_raise(ActionController::UnknownAction) { get :edit, :id=>pages(:home) }
      assert_raise(ActionController::UnknownAction) { get :new }
    end
    
    should "have children for sidebar" do
      get :show, :id=>pages(:about).permalink
      assert assigns(:pages)
      assert_equal 1, assigns(:pages).size
    end
  end
end
