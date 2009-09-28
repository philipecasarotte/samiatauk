require 'test_helper'

class MailerTest < ActionMailer::TestCase
  tests Mailer

  def setup
      ActionMailer::Base.delivery_method = :test
      ActionMailer::Base.perform_deliveries = true
      ActionMailer::Base.deliveries = []
  end
end
