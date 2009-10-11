class PhotoGallery < ActiveRecord::Base
  has_many :images, :order => "position"
  
  validates_presence_of :name, :description
  validates_uniqueness_of :permalink
  
  has_permalink :name, :update => true

  acts_as_seo
  
  named_scope :with_images, :conditions => "images_count != 0"
  
  default_scope :order => "position"
end
