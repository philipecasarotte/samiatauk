require 'activerecord'

namespace :db do
  desc "Migrate schema to version 0 and back up again. WARNING: Destroys all data in tables!!"
  task :remigrate => :environment do

      # Drop all tables
      ActiveRecord::Base.connection.tables.each { |t| ActiveRecord::Base.connection.drop_table t }

      # Migrate upward 
      Rake::Task["db:migrate"].invoke
      
      # Dump the schema
      Rake::Task["db:schema:dump"].invoke
  end
  
  desc "Populate your database."
  task :populate  => :environment do

      # Remigrate
      Rake::Task["db:remigrate"].invoke
    
      require 'dburns/setup'
      
      attributes = {
        :admin_password => "bundinha",
        :admin_login => "danieltburns",
        :admin_email => "dev.dburns@gmail.com",
        :admin_name => "Daniel Burns"
      }
      
      Dburns::Setup.bootstrap attributes
  end

  desc "Create the default pages in CMS that can't be deleted."
  task :default_pages => [:environment, :clear_default_pages] do
   puts "Creating Default Pages..."
   get_pages    
   @pages.each do |page|
     create = Page.create(:title => page[:title], :body => page[:body], :is_protected => true)
     puts "Created #{page[:title]} Page."
   end
  end

  task :clear_default_pages => :environment do
    puts "Destroying default pages before creating it again."
    get_pages
    @pages.each do |page|
     destroy = Page.find(:first, :conditions => {:title => page[:title]}) 
     Page.destroy(destroy.id) unless destroy.blank?
     puts "Deleted #{page[:title]} Page." unless destroy.blank?
    end
  end

  def get_pages
    @pages = [
                {:title => "Page Not Found", :body => "The page you requested was not found"}, 
                {:title => "Contact", :body => "Send a message to our staff"}
             ]
  end
end
