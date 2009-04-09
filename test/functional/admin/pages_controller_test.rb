require 'test_helper'

class Admin::PagesControllerTest < ActionController::TestCase

	def setup
		@controller = Admin::PagesController.new
		@request    = ActionController::TestRequest.new
		@response   = ActionController::TestResponse.new
		login_as(:admin)
	end

	context "List of pages" do

		context "in HTML" do
			setup do
				get :index
			end

			should_render_template :index
			should_respond_with_content_type :html
		end
		
		context "via Ajax" do
			setup do
				get :index, :format => 'js'
			end
			should_render_template :index
			should_respond_with_content_type :js
		end

	end

	context "Create" do
		context "an invalid page" do
			setup do
				Page.any_instance.stubs(:valid?).returns(false)
				post :create
			end
			should_render_template :new
		end

		context "a valid page" do
			setup do
				Page.any_instance.stubs(:valid?).returns(true)
				post :create
			end
			should_redirect_to("list of pages") { admin_pages_path }
		end
	end

  context "Update" do
    context "an invalid page" do
      setup do
        Page.any_instance.stubs(:valid?).returns(false)
        post :update, :id => Page.first.id
      end
      should_render_template "edit"
    end

    context "a valid page" do
      setup do
        Page.any_instance.stubs(:valid?).returns(true)
        post :update, :id => Page.first.id
      end
      should_redirect_to("list of pages") { admin_pages_path }
    end
  end

	context "Reordering pages" do
		context "when list the main pages" do
			setup do
				get :reorder
			end
			should_assign_to(:items) { Page.main_pages }
			should_render_template :reorder
		end

		context "when list children" do
			setup do
				get :reorder, :parent_id => pages(:about).id
			end
			should_assign_to(:items) { Page.find(pages(:about).id).pages }
			should_render_template :reorder
		end
		
		context "when save" do
			setup do
				post :order, :order => [pages(:home).id, pages(:about).id]
			end
			should_render_without_layout
		end
	end

end
