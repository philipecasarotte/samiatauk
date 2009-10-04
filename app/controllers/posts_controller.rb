class PostsController < ApplicationController
  def index
    @page = Page.find_by_permalink("blog")
    @posts = Post.all(:include => :comments)
    @metatag_object = @page
    
    respond_to do |format|
      format.html 
      format.xml  { render :xml => @posts }
      format.json { render :xml => @posts }
      format.atom
    end
  end
  
  def show
    @post = Post.find_by_permalink(params[:id], :include => :comments)
    @metatag_object = @post
    
    respond_to do |format|
      format.html 
      format.xml  { render :xml => @post }
    end
  end
end
