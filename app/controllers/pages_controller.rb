class PagesController < ResourceController::Base
  
  actions :all, :except=>[:new, :create, :edit, :update, :destroy]
  
  show.wants.html { @pages = @page.children }
  
  private
  def object
    @object = Page.find_by_permalink(params[:id])
  end
  
  def collection
    @collection = Page.all :conditions => "parent_id IS NULL"
  end
end
