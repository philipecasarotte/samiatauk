class PagesController < ApplicationController
  
  def index
    @pages = Page.all :conditions => 'parent_id IS NULL'
  end
  
  def contact
    @page = Page.find_by_permalink('contact')
    if request.post?
      Mailer.deliver_contact(params[:contact])
      flash[:notice] = 'Your message was sent.'
      session[:contact_params] = nil
      redirect_to(:permalink => 'contact')
      return false
    end
    return true
  end

  def method_missing(method, *args)
    @page = Page.find_by_permalink(method)
    
    @page ||= Page.find_by_permalink('page-not-found')
    
    @pages = @page.children
    render :action => method.to_s.tableize
    rescue
      render :action => 'show'
  end

end
