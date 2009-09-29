class Download < ActiveRecord::Base
  validates_presence_of :name, :subject, :description
  validates_uniqueness_of :permalink
  
  has_permalink :name, :update => true

  acts_as_seo
  
  default_scope :order => "position"
  
  named_scope :science, :conditions => ["subject = ?", "Ciência"]
  named_scope :faith, :conditions => ["subject = ?", "Evangelismo"]
  
  has_attached_file :file,
    :path => PAPERCLIP_PATH,
    :url => PAPERCLIP_URL,
    :default_url => ""
end
