class Admin::UserSessionsController < ApplicationController

  layout "admin/layouts/admin"

  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = I18n.t(:login_message)
      redirect_back_or_default admin_root_url
    else
      render :action => :new
    end
  end
  
  def destroy
    current_user_session.destroy
    flash[:notice] = I18n.t(:logout_message)
    redirect_back_or_default admin_login_url
  end

end
