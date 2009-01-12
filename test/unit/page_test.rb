require File.dirname(__FILE__) + '/../test_helper'

class PageTest < Test::Unit::TestCase
  context "A new page" do
    should_require_attributes :title, :body
    should_require_unique_attributes :title
    
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
end
