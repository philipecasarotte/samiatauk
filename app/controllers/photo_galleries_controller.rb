class PhotoGalleriesController < ApplicationController
  
  after_filter(:except => :index) {|c| c.cache_page}
  
  def index
    @first_gallery = PhotoGallery.with_images.first
    if @first_gallery
      redirect_to photo_gallery_path(@first_gallery.permalink)
    end
  end

  def show
    @photo_gallery = PhotoGallery.find_by_permalink(params[:id], :include => :images)
    @photo_galleries = PhotoGallery.with_images
    @metatag_object = @photo_gallery
  end
end
