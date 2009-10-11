require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  context "A Image" do
    should_validate_presence_of :name
    should_belong_to :photo_gallery
  end
end
