class Page < ActiveRecord::Base
  validates_presence_of :title
  
  has_permalink :title

  acts_as_tree :order => "position, title", :counter_cache => "children_count"
  acts_as_seo
  
  alias_attribute :pages, :children
  
  named_scope :main_pages, :conditions => 'parent_id IS NULL', :order => "position, title"
  
  def self.page_not_found
    find_by_permalink('page-not-found')
  end
end
