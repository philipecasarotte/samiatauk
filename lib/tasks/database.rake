require 'activerecord'

namespace :db do
  desc "Migrate schema to version 0 and back up again. WARNING: Destroys all data in tables!!"
  task :remigrate => :environment do
    # require 'highline/import'

      # Drop all tables
      ActiveRecord::Base.connection.tables.each { |t| ActiveRecord::Base.connection.drop_table t }

      # Migrate upward 
      Rake::Task["db:migrate"].invoke
      
      # Dump the schema
      Rake::Task["db:schema:dump"].invoke
  end
  
  desc "Bootstrap your database for Spree."
  task :bootstrap  => :environment do
    #return unless %w[development test].include? RAILS_ENV    
    
    # require 'highline/import'

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
end
