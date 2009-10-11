require 'test_helper'

class PhotoGalleryTest < ActiveSupport::TestCase
  context "A Potho Gallery" do
    should_have_many :images
    should_validate_presence_of :name, :description
    
    should "have a permalink when saved" do
      gallery = PhotoGallery.create(:name => "Title of Permalink", :description => "Testing text!")
      assert_equal("title-of-permalink", gallery.permalink)
    end
  end
end
