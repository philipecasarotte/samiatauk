require 'test_helper'

class DownloadsControllerTest < ActionController::TestCase
  setup do
    @controller = DownloadsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end
  
  context "A user accessing" do
    context "the index of Downloads" do
      setup do
        get :index
      end
      
      should_redirect_to("Downloads with subject Evangelismo") { faith_downloads_path }
    end
    
    context "Download of Evangelismo" do
      setup do
        @page = Factory(:page, :name => "Evangelismo")
        @download = Factory(:download)
        get :faith
      end
      
      should_render_template :faith
      should_assign_to(:downloads) { Download.faith }
    end
    
    context "Download of Ciência" do
      setup do
        @page = Factory(:page, :name => "Ciência")
        @download = Factory(:download)
        get :science
      end
      
      should_render_template :science
      should_assign_to(:downloads) { Download.science }
    end
    
    context "a Download" do
      setup do
        @download = Factory(:download)
        get :show, :id => @download.permalink
      end
      
      should_render_template :show
      should_assign_to(:download) { Download.find_by_permalink(@download.permalink) }
    end
  end
end
