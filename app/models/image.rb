class Image < ActiveRecord::Base
  belongs_to :photo_gallery, :counter_cache => true
  
  validates_presence_of :name
  
  has_attached_file :image,
                    :styles => { :big => '600x440>',:thumb => '74x74#' },
                    :path => PAPERCLIP_PATH,
                    :url => PAPERCLIP_URL,
                    :default_url => ""
  
  default_scope :order => "position"
end
