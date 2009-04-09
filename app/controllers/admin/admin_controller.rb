class Admin::AdminController < ResourceController::Base

  include AuthenticatedSystem
  include AuthorizedSystem

  include ResourceControllerView

  authorize_role "admin"

	layout "admin/layouts/admin"
	
  before_filter :login_required

  protected
  
	def access_denied
	  flash.now[:error] = "You are not authorized"
		redirect_to admin_login_path
	end
end