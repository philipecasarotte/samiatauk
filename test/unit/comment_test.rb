require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  context "A Comment" do
    should_belong_to :post
    should_validate_presence_of :name, :comment
  end
end
