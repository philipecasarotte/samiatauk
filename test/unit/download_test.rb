require 'test_helper'

class DownloadTest < ActiveSupport::TestCase
  context "A Download" do
    should_validate_presence_of :name, :subject, :description
    should_have_db_column :position, :type => "integer"
    
    should_have_named_scope :science
    should_have_named_scope :faith
    
    should "have a permalink when saved" do
      download = Download.create(:name => "Title of Permalink", :type => "Ciência", :description => "Testing text!")
      assert_equal("title-of-permalink", download.permalink)
    end
  end
end
