require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::UserSessionsController do

  mock_models :user_session

  describe "generating and recognizing routes" do
    it { should route(:get, '/admin/login', :action => :new) }
    it { should route(:delete, '/admin/logout', :action => :destroy) }
  end

  describe :get => :new do
    expects :new, :on => UserSession, :returns => mock_user_session
    should_assign_to :user_session, :with => mock_user_session
    should_render_template :new
  end

  describe :post => :create, :user_session => {:login => 'admin', :password => 'bundinha'} do
    expects :new, :on => UserSession, :with => {'login' => 'admin', 'password' => 'bundinha'}, :returns => mock_user_session

    describe "with valid credentials" do
      expects :save,  :on => mock_user_session, :returns => true
      should_set_the_flash :to => I18n.t(:login_message)
      should_redirect_to { admin_root_url }
      should_assign_to :user_session, :with => mock_user_session
    end

    describe "with invalid credentials" do
      expects :save,  :on => mock_user_session, :returns => false
      should_not_set_the_flash
      should_respond_with :success
      should_render_template :new
    end
  end
  
  describe :delete => :destroy do
    before do
      activate_authlogic
    end
    expects :find, :on => UserSession, :returns => mock_user_session
    expects :destroy, :on => mock_user_session, :returns => true
    it "should not have an user session" do
      UserSession.find.should be_nil
    end
    should_redirect_to { admin_login_url }
  end
end
