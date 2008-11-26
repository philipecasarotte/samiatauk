class Admin::AdminController < ResourceController::Base

  include AuthenticatedSystem
  include AuthorizedSystem

  authorize_role "admin"

	layout 'admin'
  before_filter :login_required

  protected
  
	def access_denied
		redirect_to new_admin_session_path
	end
end
