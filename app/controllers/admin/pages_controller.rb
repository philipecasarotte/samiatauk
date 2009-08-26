class Admin::PagesController < Admin::AdminController

  cache_sweeper :page_sweeper
  create.wants.html {redirect_to(collection_url)}
  update.wants.html {redirect_to(collection_url)}

  index.response do |format|
    format.html
    format.js { render :layout => false }
  end

  include Order

  protected
  def collection
    @collection = Page.find_all_by_parent_id(params[:parent_id]) || Page.main_pages
  end
end

