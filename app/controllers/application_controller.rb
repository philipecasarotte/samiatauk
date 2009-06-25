# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  helper_method :current_user_session, :current_user, :logged_in?

  # See ActionController::RequestForgeryProtection for details
  protect_from_forgery

  # See ActionController::Base for details
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password").
  filter_parameter_logging :password, :password_confirmation

  private
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
    end

    def require_user
      unless current_user
        store_location
        flash[:error] = I18n.t(:not_authorized)
        redirect_to admin_login_url
        return false
      end
    end

    def require_no_user
      if current_user
        store_location
        flash[:error] = I18n.t(:not_authorized)
        redirect_to admin_root_url
        return false
      end
    end

    def store_location
      session[:return_to] = request.request_uri
    end

    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end

    def logged_in?
      current_user
    end

   # to render custom error pages

    def rescue_action_in_public(exception)
      error_code = response_code_for_rescue(exception)
      case error_code
      when :not_found
        redirect_to not_found_path
      when :unprocessable_entity
        redirect_to unprocessable_entity_path
      else
        redirect_to application_error_path
      end
    end

    # Uncomment this line to view the error pages in development mode
    # alias_method :rescue_action_locally, :rescue_action_in_public


end

