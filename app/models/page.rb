class Page < ActiveRecord::Base
  validates_presence_of :name
  
  has_permalink :name

  acts_as_tree :order => "position, name", :counter_cache => "children_count"
  acts_as_seo
  
  alias_attribute :pages, :children
  
  named_scope :main_pages, :conditions => 'parent_id IS NULL', :order => "position, name"
  
  def self.page_not_found
    find_by_permalink('page-not-found')
  end
end
