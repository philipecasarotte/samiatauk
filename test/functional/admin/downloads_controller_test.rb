require 'test_helper'

class Admin::DownloadsControllerTest < ActionController::TestCase

  setup do
    @controller = Admin::DownloadsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  context 'logged as admin' do
    setup do
      activate_authlogic
      UserSession.create(Factory(:admin))
      Factory(:download)
    end
    
    context 'and get the index' do
      setup do
        get :index
      end

      should_render_template :index
    end

    context "accessing the form for new Download" do
      setup do
        get :new
      end
      should_render_template :new
    end

    context "Create" do
      context "an invalid Download" do
        setup do
          Download.any_instance.stubs(:valid?).returns(false)
          post :create
        end
        should_render_template :new
      end

      context "a valid Download" do
        setup do
          Download.any_instance.stubs(:valid?).returns(true)
          post :create
        end
        should_redirect_to("list of Download") { admin_downloads_path }
      end
    end

    context 'and get the edit page' do
      setup do
        get :edit, :id => Factory(:download)
      end
      should_render_template :edit
    end

    context 'and update a Download' do
      setup do
        @download = Factory(:download)
      end

      context 'with valid data' do
        setup do
          Download.any_instance.stubs(:valid?).returns(true)
          put :update, :id => @download
        end
        should_redirect_to('list of Downloads'){ admin_downloads_url }
      end

      context 'with invalid data' do
        setup do
          Download.any_instance.stubs(:valid?).returns(false)
          put :update, :id => @download
        end
        should_render_template :edit
      end
    end

  	context "reordering" do
      context "Downloads" do
        setup do
          get :reorder
        end
        should_assign_to(:items) { Download.all }
        should_render_template :reorder
      end

      context "Downloads and saving" do
        setup do
          post :order, :order => [Factory(:download).id, Factory(:download, :name => "Download 2").id]
        end
        should_render_without_layout
      end

    end
  end
end

