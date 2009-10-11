require 'test_helper'

class Admin::PhotoGalleriesControllerTest < ActionController::TestCase

  setup do
    @controller = Admin::PhotoGalleriesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  context 'logged as admin' do
    setup do
      activate_authlogic
      UserSession.create(Factory(:admin))
      Factory(:photo_gallery)
    end
    
    context 'and get the index' do
      setup do
        get :index
      end

      should_render_template :index
    end

    context "accessing the form for new PhotoGallery" do
      setup do
        get :new
      end
      should_render_template :new
    end

    context "Create" do
      context "an invalid PhotoGallery" do
        setup do
          PhotoGallery.any_instance.stubs(:valid?).returns(false)
          post :create
        end
        should_render_template :new
      end

      context "a valid PhotoGallery" do
        setup do
          PhotoGallery.any_instance.stubs(:valid?).returns(true)
          post :create
        end
        should_redirect_to("list of PhotoGallery") { admin_photo_galleries_path }
      end
    end

    context 'and get the edit page' do
      setup do
        get :edit, :id => Factory(:photo_gallery)
      end
      should_render_template :edit
    end

    context 'and update a PhotoGallery' do
      setup do
        @photo_gallery = Factory(:photo_gallery)
      end

      context 'with valid data' do
        setup do
          PhotoGallery.any_instance.stubs(:valid?).returns(true)
          put :update, :id => @photo_gallery
        end
        should_redirect_to('list of PhotoGalleries'){ admin_photo_galleries_url }
      end

      context 'with invalid data' do
        setup do
          PhotoGallery.any_instance.stubs(:valid?).returns(false)
          put :update, :id => @photo_gallery
        end
        should_render_template :edit
      end
    end
  end
end

