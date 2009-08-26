require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::UsersController do

  mock_models :user

  before(:each) do
    controller.stub!(:current_user).and_return(mock_user)
    mock_user.should_receive(:has_role?).with("admin").and_return(true)
  end

  describe :get => :index do
    should_assign_to :users
    should_render_template :index
    should_respond_with_content_type :html
  end
  
  describe :get => :new do
    should_render_template :new
  end

  describe :post => :create, :user => { :name => 'Whatever' } do
    expects :new, :on => User, :with => {'name' => 'Whatever'}, :returns => mock_user

    describe "with valid parameters" do
      expects :save,  :on => mock_user, :returns => true
      should_set_the_flash :to => "Successfully created!"
      should_redirect_to { admin_users_path }
    end

    describe "with invalid parameters" do
      expects :save,  :on => mock_user, :returns => false
      should_render_template :new
    end
  end
  
  # FIXME
  #
  # The below code was supposed to work for normal controllers, but it seems
  # to conflict with the factory used for login, as the model doesn't receive
  # the correct parameters for find
  #
  describe :get => :edit, :id => "1" do
    expects :find, :on => User, :with => '1', :returns => mock_user
    should_assign_to :user, :with => mock_user
    should_render_template :edit
  end
  
  describe :put => :update, :id => '1', :user => { :login => 'whatever' } do
  
    describe "with valid parameters" do
      expects :find, :on => User, :with => '1', :returns => mock_user
      expects :update_attributes,  :on => mock_user, :returns => user_proc
      should_assign_to :user, :with => user_proc
      should_redirect_to { admin_users_path }
    end
  
    describe "with valid parameters" do
      expects :find, :on => User, :with => '1', :returns => mock_user
      expects :update_attributes,  :on => mock_user, :returns => false
      should_render_template :edit
    end
  end
  
end
