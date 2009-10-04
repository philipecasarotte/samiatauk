require 'test_helper'

class Admin::CommentsControllerTest < ActionController::TestCase
  context "An admin accessing" do
    setup do
      activate_authlogic
      UserSession.create(Factory(:admin))
    end
  	context "List of comments" do

  		setup do
  			get :index, :post_id => Factory(:post)
  		end

  		should_render_template :index
  	end

  	context "New" do
  		setup do
  			get :new, :post_id => Factory(:post)
  		end
  		should_render_template :new
  	end

  	context "Create" do
  		context "an invalid comment" do
  			setup do
  				Comment.any_instance.stubs(:valid?).returns(false)
  				post :create, :post_id => Factory(:post)
  			end
  			should_render_template :new
  		end

  		context "a valid comment" do
  			setup do
  			  @post = Factory(:post)
  				Comment.any_instance.stubs(:valid?).returns(true)
  				post :create, :post_id => @post
  			end
  			should_redirect_to("list of comments") { admin_post_comments_path(@post) }
  		end
  	end

  	context "Edit" do
  		setup do
  		  @post = Factory(:post)
  		  @comment = Factory(:comment, :post_id => @post.id)
  			get :edit, :post_id => @comment.post, :id => @comment.id
  		end
  		should_render_template :edit
  	end

  	context "Update" do
  		context "an invalid comment" do
  			setup do
  			  @post = Factory(:post)
    		  @comment = Factory(:comment, :post_id => @post.id)
  				Comment.any_instance.stubs(:valid?).returns(false)
  				post :update, :post_id => @comment.post, :id => @comment.id
  			end
  			should_render_template "edit"
  		end

  		context "a valid comment" do
  			setup do
  			  @post = Factory(:post)
    		  @comment = Factory(:comment, :post_id => @post.id)
  				Comment.any_instance.stubs(:valid?).returns(true)
  				post :update, :post_id => @comment.post, :id => @comment.id
  			end
  			should_redirect_to("list of comments") { admin_post_comments_path(@comment.post) }
  		end
  	end
  end
end