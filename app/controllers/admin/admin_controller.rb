class Admin::AdminController < ResourceController::Base
  include RoleRequirementSystem
  include ResourceControllerView
  
  before_filter :require_user

  require_role "admin"


	layout "admin/layouts/admin"

  protected
  def access_denied
    if logged_in?
      flash[:error] = t(:unauthorized)
      redirect_to admin_login_url
      return false
    else
      super
    end
  end

end

