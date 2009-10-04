require 'test_helper'

class Admin::PostsControllerTest < ActionController::TestCase

  setup do
    @controller = Admin::PostsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  context 'logged as admin' do
    setup do
      activate_authlogic
      UserSession.create(Factory(:admin))
      Factory(:post)
    end
    
    context 'and get the index' do
      setup do
        get :index
      end

      should_render_template :index
    end

    context "accessing the form for new Post" do
      setup do
        get :new
      end
      should_render_template :new
    end

    context "Create" do
      context "an invalid Post" do
        setup do
          Post.any_instance.stubs(:valid?).returns(false)
          post :create
        end
        should_render_template :new
      end

      context "a valid Post" do
        setup do
          Post.any_instance.stubs(:valid?).returns(true)
          post :create
        end
        should_redirect_to("list of Post") { admin_posts_path }
      end
    end

    context 'and get the edit page' do
      setup do
        get :edit, :id => Factory(:post)
      end
      should_render_template :edit
    end

    context 'and update a Post' do
      setup do
        @post = Factory(:post)
      end

      context 'with valid data' do
        setup do
          Post.any_instance.stubs(:valid?).returns(true)
          put :update, :id => @post
        end
        should_redirect_to('list of Posts'){ admin_posts_url }
      end

      context 'with invalid data' do
        setup do
          Post.any_instance.stubs(:valid?).returns(false)
          put :update, :id => @post
        end
        should_render_template :edit
      end
    end
  end
end

