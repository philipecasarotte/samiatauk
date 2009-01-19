class AddDefaultPages < ActiveRecord::Migration
  def self.up
		Page.create(:title => 'Page Not Found', :body => 'The page you are looking for was not found.')
		Page.create(:title => 'Contact')
		Page.find("page-not-found").update_attributes(:is_protected => true)
		Page.find("contact").update_attributes(:is_protected => true)
  end

  def self.down
		Page.find('page-not-found').destroy
		Page.find('contact').destroy
  end
end
