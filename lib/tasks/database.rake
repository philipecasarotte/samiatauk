require 'activerecord'
require 'active_record/fixtures'

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
      
      Rake::Task["db:default_pages"].invoke
  end

  desc "Create the default pages in CMS that can't be deleted."
  task :default_pages => [:environment, :clear_default_pages] do
   puts "Creating Default Pages..."
   ActiveRecord::Base.establish_connection(RAILS_ENV.to_sym)
   Fixtures.create_fixtures("#{RAILS_ROOT}/lib/dburns", 'pages')
   puts "Updating children count..."
   main_pages = Page.all :conditions => 'parent_id IS NULL'
   main_pages.each do |main_page|
     children_count = main_page.children.count
     ActiveRecord::Base.connection.execute("UPDATE pages p SET children_count = #{children_count} WHERE p.id = #{main_page.id}; ")
     puts "#{main_page.name} updated to #{children_count} children."
   end
   puts "Done"
  end

  task :clear_default_pages => :environment do
    puts "Destroying default pages before creating it again."
    Page.destroy_all
  end

end
