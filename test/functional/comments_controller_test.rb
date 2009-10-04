require 'test_helper'
require 'comments_controller'

class CommentsControllerTest < ActionController::TestCase

  test "should create comment" do
    assert_difference('Comment.count') do
      @post = Factory(:post)
      post :create, :post_id => @post, :comment => { :name => "Phil", :email => "tit@tot.com.br", :website => "http://www.uol.com.br", :comment => "MyText" }
    end

    assert_redirected_to post_path(@post)
  end

end