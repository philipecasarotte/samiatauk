class Post < ActiveRecord::Base
  has_many :comments
  
  validates_presence_of :name, :body
  validates_uniqueness_of :permalink
  
  has_permalink :name, :update => true

  acts_as_seo
  
  default_scope :order => "published_on DESC"
end
