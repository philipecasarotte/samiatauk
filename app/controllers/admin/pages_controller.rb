class Admin::PagesController < Admin::AdminController
  create.wants.html do 
    params[:page][:parent_id] ? redirect_to(admin_pages_path(:parent_id=>params[:page][:parent_id])) : redirect_to(admin_pages_path)
  end
  
  update.wants.html do
    params[:page][:parent_id] ? redirect_to(admin_pages_path(:parent_id=>params[:page][:parent_id])) : redirect_to(admin_pages_path)
  end
  
  destroy.wants.html do
    @object.parent_id ? redirect_to(admin_pages_path(:parent_id=>@object.parent_id)) : redirect_to(admin_pages_path)
  end
  
  protected
  def collection
    @collection = Page.find(params[:parent_id]).children
    rescue
    @collection = Page.all :conditions=>"parent_id IS NULL"
  end
end
