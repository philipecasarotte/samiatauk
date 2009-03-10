# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  include AuthenticatedSystem
  include AuthorizedSystem

  before_filter :before_meta_tag
  # See ActionController::RequestForgeryProtection for details
  protect_from_forgery
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  filter_parameter_logging :password
  
  protected
  def before_meta_tag
    @metatag = nil
    @title = ".:: " + SITE_NAME + " ::."
    @keyword = ""
    @description = ""
  end
  
  def rescue_action_in_public(exception)
    redirect_to page_path('page-not-found')
  end
  
end
