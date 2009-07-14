class UserSession < Authlogic::Session::Base
  
  logout_on_timeout true if ENV['RAILS_ENV'] == 'production'

end