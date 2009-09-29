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
      :user_name => "samiatauk@gmail.com",
      :password => "dev@1942!"
  }
  
  def contact(params)
    @recipients = SITE_EMAIL
    @from = params[:email] if params[:email]
    @reply_to = params[:email] if params[:email]
    @subject = I18n.t(:contact_from) + " #{SITE_DOMAIN}"
    @sent_on = Time.now
    @content_type = 'text/html'
    
    body[:params] = params
  end


end
