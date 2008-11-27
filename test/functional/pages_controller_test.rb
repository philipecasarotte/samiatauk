require File.dirname(__FILE__) + '/../test_helper'
require 'pages_controller'

# Re-raise errors caught by the controller.
class PagesController; def rescue_action(e) raise e end; end

class PagesControllerTest < Test::Unit::TestCase
  
  context "Page controller" do
  
    setup do
      @controller = PagesController.new
      @request    = ActionController::TestRequest.new
      @response   = ActionController::TestResponse.new
    end
  
    should "get index" do
      get :index
      assert assigns(:pages)
      assert_equal 2, assigns(:pages).size
    end
    
    should "get show" do
      get pages(:home).permalink
      assert assigns(:page)
    end
  
    should "have children for sidebar" do
      get pages(:about).permalink
      assert assigns(:pages)
      assert_equal 1, assigns(:pages).size
    end
  end
  
  context "When a user sends the contact form" do
    setup do
      @controller = PagesController.new
      @request    = ActionController::TestRequest.new
      @response   = ActionController::TestResponse.new
      ActionMailer::Base.delivery_method = :test
      ActionMailer::Base.perform_deliveries = true
      ActionMailer::Base.deliveries = []
      post :contact, 'contact' => {'name' => "Ricardo", 'email' => "ricardo@dburnsdesign.com", 'message' => 'Hello!'}
    end

    should "send contact e-mail" do
      assert_sent_email do |email|
        email.from.include?('ricardo@dburnsdesign.com') && email.subject =~ /Contact From/
      end
    end
    
    should_set_the_flash_to(/Your message was sent/i)
  end

end
