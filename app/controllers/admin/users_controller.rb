class Admin::UsersController < Admin::AdminController

  protected
  def collection
    if params[:role] == 'admin'
      @collection = User.admins
    else
      @collection = User.all
    end
  end

end
