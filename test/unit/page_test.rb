require File.dirname(__FILE__) + '/../test_helper'

class PageTest < ActiveSupport::TestCase
  context "A Page" do
    should_validate_presence_of :name
    should_have_many :children, :dependent => :destroy
    should_belong_to :parent
    should_eventually "have named scope :main_pages"
    
    should_have_db_column :position, :type => "integer"
    
    should "have the children method" do
      @page = Factory(:page)
      assert_respond_to(@page.children.create, :children)
      assert_kind_of(Array, Page.new.children)
      
      assert_equal @page.children.size, 1
    end
    
    should "have a permalink when saved" do
      page = Page.create(:name => "Title of Permalink", :body => "Testing text!")
      assert_equal("title-of-permalink", page.permalink)
    end

    should "update the permalink when update the title" do
      @page = Factory(:about)
      @page.update_attribute(:name, "Home")
      assert_equal("home", @page.permalink)
    end

    context "with duplicated title" do
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

      should "have different permalinks" do
        assert_equal('page', @page_one.permalink)
        assert_equal("page-2", @page_two.permalink)
        assert_equal('page-3', @page_three.permalink)

        assert_equal("#{@page_one.id}-page", @page_one.to_param)
      end
    end

    context "protected" do
      setup do
        @page = Factory(:page, :is_protected => true)
      end

      should "not change the permalink" do
        permalink = @page.permalink

        assert(@page.is_protected)

        @page.update_attribute(:name,"CHANGED")

        assert_equal(permalink, @page.permalink)
      end
    end

    context "with especial characters" do
      setup do
        @page = Page.create(:name => "Página & $ * é nóis")
      end

      should "accented to permalink" do
        assert_equal("pagina-e-nois", @page.permalink)
      end
    end

  end

end
