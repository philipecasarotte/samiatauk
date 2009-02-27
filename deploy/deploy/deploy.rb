set :deploy_to, "/home/"
set :application, "project-slug" # CHANGE ME
set :uri, "project.uri" # CHANGE ME

set :host, "server's ip" # CHANGE ME
set :deploy_to, "/path/to/project/directory/at/deploy/server" # CHANGE ME

set :current_deployment, "#{deploy_to}/current"
set :keep_releases, 4
set :ssh_options, { :forward_agent => true }

role :app, "#{host}"

set :repository,  "public-repository" # CHANGE ME
set :scm, :git

set :user, "root"
set :password, "root-password" # CHANGE ME
set :sudo_prompt, ""
ssh_options[:paranoid] = false

load 'deploy'

namespace :deploy do
  
  namespace :install do
    
    task :packages do
    
      run "apt-get update"
    
      packages = {
        :ruby => %w(ruby ri rdoc irb ruby1.8-dev libopenssl-ruby),
        :mysql => %w(mysql-server libmysql++-dev),
        :image => %w(imagemagick),
        :web => %w(apache2 apache2-prefork-dev),
        :util => %w(build-essential git-core)
      }
    
      run "apt-get -y install #{packages.map { |k,v| v } * ' '}"
      
    end
    
    task :rubygems do
      uri = "http://rubyforge.org/frs/download.php/45905/rubygems-1.3.1.tgz"
      
      steps = ["cd /tmp", 
               "wget #{uri}", 
               "tar xzvf rubygems-1.3.1.tgz", 
               "cd rubygems-1.3.1", 
               "ruby setup.rb", 
               "cd ..",
               "rm -Rf ruby*"]
               
      run steps * ' && '
    end
    
    task :gems do
      gems = %w(rails mislav-will_paginate unicode passenger mysql tlsmail)
      steps = ["gem1.8 sources -a http://gems.github.com",
               "gem1.8 install #{gems * ' '} --no-ri --no-rdoc"]
               
      run steps.join(' && ')
    end
    
    task :passenger do
      run("gem1.8 list | grep passenger") do |ch, stream, data|
        @version = data.sub(/passenger \(([^,]+)\).*/,"\\1").strip
      end
      
      passenger_module
      configure_passenger
    end

    task :passenger_module do
      run "cd /usr/lib/ruby/gems/1.8/gems/passenger-#{@version} && rake apache2"
    end

    task :configure_passenger do
      passenger_config = <<-EOF
        LoadModule passenger_module /usr/lib/ruby/gems/1.8/gems/passenger-#{@version}/ext/apache2/mod_passenger.so
        PassengerRoot /usr/lib/ruby/gems/1.8/gems/passenger-#{@version}
        PassengerRuby /usr/bin/ruby1.8
      EOF

      put passenger_config, "/tmp/passenger"
      run "mv /tmp/passenger /etc/apache2/conf.d/passenger"
    end
    
    task :user do
      run "useradd -p dev@1942! -d #{deploy_to} deploy"
    end
    
  end
  
  namespace :config do
    task :apache do
      run "rm -f /etc/apache2/sites-enabled/000-default"
      
      template = File.read(File.dirname(__FILE__) + '/templates/apache.erb')
      buffer = ERB.new(template).result(binding)
      
      put buffer, "/etc/apache2/sites-available/#{uri}"
      run "ln -nfs /etc/apache2/sites-available/#{uri} /etc/apache2/sites-enabled/"
    end
    
    task :directories do
      steps = ["mkdir #{current_deployment}/public/uploads", 
               "chmod -R 777 #{current_deployment}/public/uploads"]
               
      run steps * ' && '
    end
    
    task :databases do
      steps = ["cd #{current_deployment}",
               "rake db:create:all",
               "rake db:migrate",
               "RAILS_ENV=test rake db:migrate",
               "RAILS_ENV=production rake db:migrate"]
               
      run steps * ' && '
    end
    
    task :database_yml do
      template = File.read(File.dirname(__FILE__) + '/templates/database.erb')
      buffer = ERB.new(template).result(binding)
      
      run "mkdir -p #{deploy_to}/shared/config"
      put buffer, "#{deploy_to}/shared/config/database.yml"
      database_yml_link
    end
    
    task :database_yml_link do
      run "ln -nfs #{deploy_to}/shared/config/database.yml #{current_deployment}/config/database.yml"
    end
    
    task :permissions do
      run "chown -R deploy:deploy #{deploy_to}"
    end
  end
  
  task :restart do
    run "/etc/init.d/apache2 restart"
  end
  
end

after 'deploy:install:packages', 'deploy:install:rubygems'
after 'deploy:install:rubygems', 'deploy:install:gems'
after 'deploy:install:gems', 'deploy:install:passenger'
after 'deploy:install:passenger', 'deploy:install:user'

after 'deploy', 'deploy:config:database_yml'
after 'deploy:config:database_yml', 'deploy:config:databases'
after 'deploy:config:databases', 'deploy:config:directories'
after 'deploy:config:databases', 'deploy:config:apache'
after 'deploy:config:apache', 'deploy:restart'

after 'deploy:update', 'deploy:restart'
after 'deploy:symlink', 'deploy:config:database_yml_link'
after 'deploy:update_code', 'deploy:config:permissions'