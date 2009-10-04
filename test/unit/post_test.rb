require 'test_helper'

class PostTest < ActiveSupport::TestCase
  context "A Post" do
    should_have_many :comments
    should_validate_presence_of :name, :body
    
    should "have a permalink when saved" do
      post = Post.create(:name => "Title of Permalink", :body => "Testing text!")
      assert_equal("title-of-permalink", post.permalink)
    end
  end
end
