require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  
  setup do
    @controller = PagesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  context "Page controller" do
  
    context "on GET to index" do
      setup do
        get :index
      end

      should_assign_to(:pages) { Page.main_pages }
    end
    
    context "on GET to show" do
      setup do
        get pages(:home).permalink
      end

      should_assign_to(:page) { Page.find_by_permalink(pages(:home).permalink) }
    end
    
    context "with children for sidebar" do
      setup do
        get pages(:about).permalink
      end

      should_assign_to(:pages) { Page.find_by_permalink(pages(:about).permalink).children }
    end
    
  end
  
  context "When a user sends the contact form" do
    setup do
      ActionMailer::Base.delivery_method = :test
      ActionMailer::Base.perform_deliveries = true
      ActionMailer::Base.deliveries = []
      post :contact, 'contact' => {'name' => "Ricardo", 'email' => "dev.dburns@gmail.com", 'message' => 'Hello!'}
    end
    
    should "render the contact's template" do
      get "contact"
      assert_template "contact"
    end

    should "send contact e-mail" do
      assert_sent_email do |email|
        email.from.include?('dev.dburns@gmail.com') && email.subject =~ /Contact From/
      end
    end
    
    should_set_the_flash_to(/Your message was sent/i)
  end
  
  context "Trying to get a page with a existing method" do
    setup do
      PagesController.class_eval do 
        def testing
          @testing = "Testing"
        end
        
        def it_s_a_joke
          @file_attribute = true
        end
      end
    end
    
    should "return the @testing value" do
      assert_respond_to(@controller, :testing)
      
      get 'testing'
      assert_equal "Testing", assigns(:testing)
      assert_template "show"
    end
    
    should "return the joke" do
      get 'it-s-a-joke'
      
      assert assigns(:file_attribute)
      assert_template "show"
    end
  end

end
