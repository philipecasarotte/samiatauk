require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  setup do
    @controller = PostsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end
  
  context "A user accessing" do
    context "the index of Posts" do
      setup do
        @page = Factory(:page, :name => "Blog", :permalink => "blog", :body => "Test")
        get :index
      end
      
      should_render_template :index
    end
    
    context "a Post" do
      setup do
        @post = Factory(:post)
        get :show, :id => @post.permalink
      end
      
      should_render_template :show
      should_assign_to(:post) { Post.find_by_permalink(@post.permalink) }
    end
  end
end
