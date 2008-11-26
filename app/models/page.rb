class Page < ActiveRecord::Base
  validates_presence_of :title, :body
  validates_uniqueness_of :title
  
  has_permalink :title
  acts_as_tree
  acts_as_seo
  
  def summary(size = 100)
    ApplicationController.helpers.truncate(ApplicationController.helpers.sanitize(body), size)
  end
end
