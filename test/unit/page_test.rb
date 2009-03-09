require File.dirname(__FILE__) + '/../test_helper'

class PageTest < Test::Unit::TestCase
  context "An instance of page" do
    should_validate_presence_of :title
    should_have_many :children
    should_belong_to :parent
    should_have_named_scope :main_pages
    
    should "have the children method" do
      assert_respond_to(pages(:about).children.create, :children)
      assert_kind_of(Array, Page.new.children)
      
      assert_equal pages(:about).children.size, 1
    end
    
    should "have a permalink when saved" do
      page = Page.create(:title => "Title of Permalink", :body => "Testing text!")
      assert_equal("title-of-permalink", page.slug.name)
    end
  end
  
  context "A page instance" do
    should "be able to have children" do
      assert_difference "Page.count", 1 do
        assert_difference "pages(:home).children.size", 1 do
          pages(:home).children.create(:title=>"Sign Up", :body=>"Sign up text!")
        end
      end
    end
    
    should "have a summary method" do
      assert_equal(100, pages(:home).summary.size)
      assert_equal(50, pages(:home).summary(50).size)
    end
    
    should "update the permalink when update the title" do
      pages(:home).title = "Home"
      pages(:home).save
      
      assert_equal("home", pages(:home).slug.name)
      
      pages(:home).update_attribute(:title, "Home Page")
      assert_equal("home-page", pages(:home).slug.name)
    end
  end
  
  context "Destroying page" do
    
    should "destroy all children" do
      assert_difference "Page.count", -2 do
        pages(:about).destroy
      end
    end
    
  end
  
  context "Pages with duplicated title" do
    setup do
      @page_one ||= Page.new(:title=>'Page', :body=>'Lorem')
      @page_two ||= Page.new(:title=>'Page', :body=>'Lorem')
      @page_three ||= Page.new(:title=>'Page', :body=>'Lorem')
      @page_one.save
      @page_two.save
      @page_three.save
    end

    should "be able to be created" do
      assert(!@page_one.new_record?)
      assert(!@page_two.new_record?)
      assert(!@page_three.new_record?)
    end
    
    should "have different slugs" do
      assert_equal('page', @page_one.to_param)
      assert_equal('page--2', @page_two.to_param)
      assert_equal('page--3', @page_three.to_param)
    end
  end
  
  
  context "When a Page is protected" do
    setup do
      @page = pages(:protected_page)
    end

    should "not change the slug" do
      slug = @page.slug.name
      
      assert(@page.is_protected)
      
      @page.update_attribute(:title,"CHANGED")
      
      assert_equal(slug, @page.slug.name)
    end
  end
  
end
