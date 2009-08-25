require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::PagesController do

  mock_models :page

  before(:each) do
    activate_authlogic
    UserSession.create(Factory(:admin))
  end

  describe "generating and recognizing routes" do
    it { should route(:get, '/admin/pages/reorder', :action => :reorder) }
    it { should route(:post, '/admin/pages/order', :action => :order) }
  end

  describe :get => :index do
    expects :find, :on => Page, :with => nil, :returns => mock_page
    expects :pages, :on => mock_page, :returns => mock_page
    should_assign_to :collection, :with => mock_page
 
    describe "in HTML" do
      should_render_template :index
      should_respond_with_content_type :html
    end
    
    describe Mime::JS do
      should_render_template :index
      should_render_without_layout
      should_respond_with_content_type :js
    end
  end
  
  describe :get => :new do
    expects :new, :on => Page, :returns => mock_page
    should_assign_to :page, :with => mock_page
    should_render_template :new
  end

  describe :post => :create, :page => { :name => 'Whatever' } do
    expects :new, :on => Page, :with => {'name' => 'Whatever'}, :returns => mock_page

    describe "with valid parameters" do
      expects :save,  :on => mock_page, :returns => true
      should_redirect_to { admin_pages_path }
    end

    describe "with invalid parameters" do
      expects :save,  :on => mock_page, :returns => false
      should_render_template :new
    end
  end
  
  describe :get => :edit, :id => '42' do
    expects :find, :on => Page, :with => '42', :returns => mock_page
    should_assign_to :page, :with => mock_page
    should_render_template :edit
  end

  describe :put => :update, :id => "1", :page => { :body => 'Whatever' } do
    expects :find, :on => Page, :with => "1", :returns => proc {mock_page}

    describe "with valid parameters" do
      expects :update_attributes,  :on => mock_page, :with => {'body' => 'Whatever'}, :returns => page_proc
      should_assign_to :page, :with => page_proc
      should_redirect_to { admin_pages_path }
    end

    describe "with valid parameters" do
      expects :update_attributes,  :on => mock_page, :returns => false
      should_render_template :edit
    end
  end
  
  describe :get => :reorder do
    expects :find, :on => Page, :with => nil, :returns => mock_page
    expects :pages, :on => mock_page, :returns => mock_page
    should_assign_to :items, :with => mock_page
    should_render_template :reorder
  end

  describe :get => :reorder, :parent_id => "1" do
    expects :find, :on => Page, :with => "1", :returns => mock_page
    expects :pages, :on => mock_page, :returns => mock_page
    should_assign_to :items, :with => mock_page
    should_render_template :reorder
  end
  
  describe :post => :order, :order => ['2','1'] do
    expects :find, :on => Page, :with => "1", :returns => mock_page
    expects :find, :on => Page, :with => "2", :returns => mock_page
    expects :update_attribute, :on => mock_page, :with => [:position, 0], :returns => true
    expects :update_attribute, :on => mock_page, :with => [:position, 1], :returns => true
    should_render_without_layout
  end

end
