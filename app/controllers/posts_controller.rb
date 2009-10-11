class PostsController < ApplicationController
  def index
    @posts = Post.all(:include => :comments)
    get_page
    
    respond_to do |format|
      format.html 
      format.xml  { render :xml => @posts }
      format.json { render :xml => @posts }
      format.atom
    end
  end
  
  def by_date
    @posts = Post.all(:conditions => "MONTH(published_on) = #{params[:month]} AND YEAR(published_on) = #{params[:year]}")
    get_page
  end
  
  def show
    @post = Post.find_by_permalink(params[:id], :include => :comments)
    @metatag_object = @post
    
    respond_to do |format|
      format.html 
      format.xml  { render :xml => @post }
    end
  end
  
  def get_page
    @posts_by_date = Post.by_date
    @page = Page.find_by_permalink("blog")
    @metatag_object = @page
  end
end
