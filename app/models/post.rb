class Post < ActiveRecord::Base
  has_many :comments, :dependent => :destroy
  
  validates_presence_of :name, :body
  validates_uniqueness_of :permalink
  
  has_permalink :name, :update => true

  acts_as_seo
  
  named_scope :by_date, :group => "MONTH(published_on), YEAR(published_on)"
  
  default_scope :order => "published_on DESC"
end
