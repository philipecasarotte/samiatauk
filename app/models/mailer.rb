class Mailer < ActionMailer::Base
  
  require 'tlsmail'

  Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)
  
  ActionMailer::Base.raise_delivery_errors = true

  ActionMailer::Base.smtp_settings = {
      :tls => true,
      :address => "smtp.gmail.com",
      :port => "587",
      :domain => SITE_DOMAIN,
      :authentication => :plain,
      :user_name => "dev.dburns@gmail.com",
      :password => "dev@1942!"
  }
  
  def contact(params)
    @recipients = 'dev.dburns@gmail.com' 
    # @recipients = SITE_EMAIL     # UNCOMMENT THIS IN PRODUCTION!
    @from = params[:email] if params[:email]
    headers['Reply-To'] = params[:email] if params[:email]
    @subject = "Contact From #{SITE_DOMAIN}"
    @sent_on = Time.now
    @content_type = 'text/html'
    
    body[:params] = params
  end


end
