class DownloadsController < ApplicationController
  
  def index
    redirect_to faith_downloads_path
  end
  
  def faith
    @page = Page.find_by_permalink("evangelismo")
    @downloads = Download.faith
    @metatag_object = @page
  end
  
  def science
    @page = Page.find_by_permalink("ciencia")
    @downloads = Download.science
    @metatag_object = @page
  end
  
  def show
    @download = Download.find_by_permalink(params[:id])
    @metatag_object = @download
  end
end
