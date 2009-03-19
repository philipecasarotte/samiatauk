class Admin::PagesController < Admin::AdminController

  cache_sweeper :page_sweeper
  edit.before{expire_page "/pages/#{object.permalink}"}
  create.wants.html {redirect_to(collection_url)}
  update.wants.html {redirect_to(collection_url)}

  index.response do |format|
    format.html
    format.js { render :layout => false }
  end

  include Order
  
  protected
  def collection
    @collection = Page.find(params[:parent_id]).pages
    rescue
    @collection = Page.main_pages
  end
end
