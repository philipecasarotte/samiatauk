class InsertDefaultPages < ActiveRecord::Migration
  def self.up
		[
			Page.new(:title => 'Page Not Found', :permalink => 'page-not-found', :body => 'The page you are looking for was not found: %params[old_permalink]%.'),
			Page.new(:title => 'Contact', :permalink => 'contact', :body => 'Send a message to %const[SITE_NAME]%\'s staff.'),
			Page.new(:title => 'Message Sent', :permalink => 'message-sent', :body => 'Your message was sent and we will reply soon. Thanks for the contact.'),
		].each do |page|
			unless Page.find_by_permalink(page.permalink)
				page.save!
			end
		end  
	end

  def self.down
    Page.find_by_permalink('page-not-found').destroy
    Page.find_by_permalink('contact').destroy
    Page.find_by_permalink('message-sent').destroy
  end
end
