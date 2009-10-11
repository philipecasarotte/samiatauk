class ImagesController < ApplicationController
  def show
    @image = Image.find(params[:id], :include => :photo_gallery)
  end
end
