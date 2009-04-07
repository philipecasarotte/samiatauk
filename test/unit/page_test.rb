require File.dirname(__FILE__) + '/../test_helper'

class PageTest < ActiveSupport::TestCase
  context "An instance of page" do
    should_validate_presence_of :name
    should_have_many :children
    should_belong_to :parent
    should_have_named_scope :main_pages
    
    should "have the children method" do
      assert_respond_to(pages(:about).children.create, :children)
      assert_kind_of(Array, Page.new.children)
      
      assert_equal pages(:about).children.size, 1
    end
    
    should "have a permalink when saved" do
      page = Page.create(:name => "Title of Permalink", :body => "Testing text!")
      assert_equal("title-of-permalink", page.permalink)
    end
  end
  
  context "A page instance" do
    should "be able to have children" do
      assert_difference "Page.count", 1 do
        assert_difference "pages(:home).children.size", 1 do
          pages(:home).children.create(:name=>"Sign Up", :body=>"Sign up text!")
        end
      end
    end
    
    should "update the permalink when update the name" do
      @page = pages(:home)
      @page.update_attribute(:name, "Home")
      assert_equal("home", @page.permalink)
    end
  end
  
  context "Destroying page" do
    
    should "destroy all children" do
      assert_difference "Page.count", -2 do
        pages(:about).destroy
      end
    end
    
  end
  
  context "Pages with duplicated name" do
    setup do
      @page_one ||= Page.new(:name=>'Page', :body=>'Lorem')
      @page_two ||= Page.new(:name=>'Page', :body=>'Lorem')
      @page_three ||= Page.new(:name=>'Page', :body=>'Lorem')
      @page_one.save
      @page_two.save
      @page_three.save
    end

    should "be able to be created" do
      assert(!@page_one.new_record?)
      assert(!@page_two.new_record?)
      assert(!@page_three.new_record?)
    end
    
    # should "have different permalinks" do
    #   assert_equal('page', @page_one.to_param)
    #   assert_equal("#{@page_two.id}-page", @page_two.to_param)
    #   assert_equal('page--3', @page_three.to_param)
    # end
  end
  
  
  context "When a Page is protected" do
    setup do
      @page = pages(:protected_page)
    end

    should "not change the permalink" do
      permalink = @page.permalink
      
      assert(@page.is_protected)
      
      @page.update_attribute(:name,"CHANGED")
      
      assert_equal(permalink, @page.permalink)
    end
  end
  
end
