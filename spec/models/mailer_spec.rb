require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Mailer do

  before(:each) do
    ActionMailer::Base.deliveries = []
  end

  it 'should send contact' do
    Mailer.deliver_contact(:email => 'dev.dburns@gmail.com')
    sent.first.subject.should =~ /#{I18n.t(:contact_from)}/
    sent.first.from.first.should =~ /dev.dburns@gmail.com/
  end

  def sent
    ActionMailer::Base.deliveries
  end
end