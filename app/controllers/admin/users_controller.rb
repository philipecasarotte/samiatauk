class Admin::UsersController < Admin::AdminController

  create.wants.html {redirect_to(collection_url)}
  update.wants.html {redirect_to(collection_url)}

  protected
  def collection
    if params[:role] == 'admin'
      @collection = User.admins
    else
      @collection = User.all
    end
  end

end
