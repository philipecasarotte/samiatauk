class PagesController < ApplicationController
  
  def index
    @pages = Page.main_pages
  end
  
  def contact
    @page = Page.find('contact')
    if request.post?
      Mailer.deliver_contact(params[:contact])
      flash[:notice] = 'Your message was sent.'
    end
    load_meta_tag
  end

  def method_missing(method, *args)
    begin
      @page = Page.find(method)
    rescue
      @page = Page.page_not_found
    end
    @pages = @page.pages
    load_meta_tag
    send(method.underscore) if respond_to?(method.underscore)
    
    render :action => method.underscore
    rescue ActionView::MissingTemplate
      render :action => 'show'
  end
  
  protected
  def load_meta_tag
    @metatag = @page.metatag
  end

end
