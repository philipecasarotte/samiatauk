class Page < ActiveRecord::Base
  validates_presence_of :title, :body
  validates_uniqueness_of :title
  
  has_friendly_id :title, :use_slug => true
  
  acts_as_tree :order => "position, title", :counter_cache => "children_count"
  acts_as_seo
  
  has_many :pages, :class_name=>"Page", :foreign_key=>"parent_id", :order => "position, title", :include=>:slugs
  
  named_scope :main_pages, :conditions=>'parent_id IS NULL', :order => "position, title", :include=>:slugs
  
  def self.page_not_found
    find('page-not-found')
  end
  
  def summary(size = 100)
    body.summary(size)
  end
end
