class Page < ActiveRecord::Base
  validates_presence_of :title, :body
  validates_uniqueness_of :title
  
  has_permalink :title
  acts_as_tree
  acts_as_seo
  
  named_scope :main_pages, :conditions=>'parent_id IS NULL'
  
  def self.page_not_found
    find_by_permalink('page-not-found')
  end
  
  def summary(size = 100)
    body.summary(size)
  end
end
