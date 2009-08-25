require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PagesController do

  mock_models :page

  describe "generating and recognozing routes" do
    it { should route(:get, '/pages/page-permalink', :action => 'page-permalink') }
  end

  describe :get => :index do
    expects :find, :on => Page, :returns => mock_page
    should_assign_to :pages, :with => mock_page
  end

  describe :get => :about do
    expects :find_by_permalink, :on => Page, :with => 'about', :returns => mock_page
    expects :pages, :on => mock_page, :returns => mock_page
    should_assign_to :page, :with => mock_page
    should_assign_to :pages, :with => mock_page
    should_assign_to :metatag_object, :with => mock_page
  end
  
  describe :get => :contact do
    expects :find_by_permalink, :on => Page, :with => 'contact', :returns => mock_page
    should_assign_to :page, :with => mock_page
    should_assign_to :metatag_object, :with => mock_page
    should_render_template :contact
  end

  describe :post => :contact, :contact => {} do
    expects :find_by_permalink, :on => Page, :with => 'contact', :returns => mock_page
    should_assign_to :page, :with => mock_page
    should_assign_to :metatag_object, :with => mock_page
    should_set_the_flash :to => I18n.t(:message_sent)
    should_render_template :contact
  end
end
