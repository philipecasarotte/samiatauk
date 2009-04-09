require 'test_helper'

class Admin::PagesControllerTest < ActionController::TestCase

  def setup
    @controller = Admin::PagesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    login_as(:admin)
  end

  context "List of pages" do

    context "in HTML" do
      setup do
        get :index
      end

      should_respond_with_content_type :html
    end
    
    context "via Ajax" do
      setup do
        get :index, :format => 'js'
      end

      should_respond_with_content_type :js
      should_render_without_layout
    end
    
  end

  context "Create" do
    context "an invalid page" do
      setup do
        Page.any_instance.stubs(:valid?).returns(false)
        post :create
      end
      should_render_template "new"
    end

    context "a valid page" do
      setup do
        Page.any_instance.stubs(:valid?).returns(true)
        post :create
      end
      should_redirect_to("list of pages") { admin_pages_path }
    end
  end

  context "Update" do
    context "an invalid page" do
      setup do
        Page.any_instance.stubs(:valid?).returns(false)
        post :update, :id => pages(:home)
      end
      should_render_template "edit"
    end

    context "a valid page" do
      setup do
        Page.any_instance.stubs(:valid?).returns(true)
        post :update, :id => pages(:home)
      end
      should_redirect_to("list of pages") { admin_pages_path }
    end
  end

end
