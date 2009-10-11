require 'test_helper'

class Admin::ImagesControllerTest < ActionController::TestCase
  context "An admin accessing" do
    setup do
      activate_authlogic
      UserSession.create(Factory(:admin))
    end
  	context "List of images" do

  		setup do
  			get :index, :photo_gallery_id => Factory(:photo_gallery)
  		end

  		should_render_template :index
  	end

  	context "New" do
  		setup do
  			get :new, :photo_gallery_id => Factory(:photo_gallery)
  		end
  		should_render_template :new
  	end

  	context "Create" do
  		context "an invalid image" do
  			setup do
  				Image.any_instance.stubs(:valid?).returns(false)
  				post :create, :photo_gallery_id => Factory(:photo_gallery)
  			end
  			should_render_template :new
  		end

  		context "a valid image" do
  			setup do
  			  @photo_gallery = Factory(:photo_gallery)
  				Image.any_instance.stubs(:valid?).returns(true)
  				post :create, :photo_gallery_id => @photo_gallery
  			end
  			should_redirect_to("list of images") { admin_photo_gallery_images_path(@photo_gallery) }
  		end
  	end

  	context "Edit" do
  		setup do
  		  @photo_gallery = Factory(:photo_gallery)
  		  @image = Factory(:image, :photo_gallery_id => @photo_gallery.id)
  			get :edit, :photo_gallery_id => @image.photo_gallery, :id => @image.id
  		end
  		should_render_template :edit
  	end

  	context "Update" do
  		context "an invalid image" do
  			setup do
  			  @photo_gallery = Factory(:photo_gallery)
    		  @image = Factory(:image, :photo_gallery_id => @photo_gallery.id)
  				Image.any_instance.stubs(:valid?).returns(false)
  				post :update, :photo_gallery_id => @image.photo_gallery, :id => @image.id
  			end
  			should_render_template "edit"
  		end

  		context "a valid image" do
  			setup do
  			  @photo_gallery = Factory(:photo_gallery)
    		  @image = Factory(:image, :photo_gallery_id => @photo_gallery.id)
  				Image.any_instance.stubs(:valid?).returns(true)
  				post :update, :photo_gallery_id => @image.photo_gallery, :id => @image.id
  			end
  			should_redirect_to("list of images") { admin_photo_gallery_images_path(@image.photo_gallery) }
  		end
  	end
  end
end