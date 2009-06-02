class Admin::AdminController < ResourceController::Base
  include RoleRequirementSystem
  include ResourceControllerView
  
  before_filter :require_user

  require_role "admin"


	layout "admin/layouts/admin"

end

