require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Page do

  should_validate_presence_of :name
  should_have_many :children, :dependent => :destroy
  should_belong_to :parent
  should_have_db_column :position, :type => "integer"

  it "should have the children method" do
    @page = Factory(:page)
    @page.children.create.should respond_to(:children)
    Page.new.children.should be_kind_of(Array)
    
    @page.children.size.should == 1
  end

  it "should have a permalink when saved" do
    page = Page.create(:name => "Title of Permalink", :body => "Testing text!")
    page.permalink.should == "title-of-permalink"
  end

  it "should update the permalink when update the title" do
    @page = Factory(:about)
    @page.update_attribute(:name, "Home")
    @page.permalink.should == "home"
  end

  context "with duplicated title" do
    before(:each) do
      @page_one ||= Page.new(:name=>'Page', :body=>'Lorem')
      @page_two ||= Page.new(:name=>'Page', :body=>'Lorem')
      @page_three ||= Page.new(:name=>'Page', :body=>'Lorem')
      @page_one.save
      @page_two.save
      @page_three.save
    end

    it "should be able to be created" do
      @page_one.new_record?.should be_false
      @page_two.new_record?.should be_false
      @page_three.new_record?.should be_false
    end

    it "should have different permalinks" do
      @page_one.permalink.should == 'page'
      @page_two.permalink.should == 'page-2'
      @page_three.permalink.should == 'page-3'
    
      @page_one.to_param.should == "#{@page_one.id}-page"
    end
  end

  context "protected" do
    before(:each) do
      @page = Factory(:page, :is_protected => true)
    end

    it "should not change the permalink" do
      permalink = @page.permalink
      @page.is_protected.should be_true

      @page.update_attribute(:name,"CHANGED")
      @page.permalink.should == permalink
    end
  end

  context "with especial characters" do
    before(:each) do
      @page = Page.create(:name => "Página & $ * é nóis")
    end

    it "should remove accents from permalink" do
      @page.permalink.should == "pagina-e-nois"
    end
  end

end
