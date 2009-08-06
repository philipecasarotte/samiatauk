# =============================================================================
# CONFIGURE OS VALORES DE ACORDO COM SUA HOSPEDAGEM
# =============================================================================
set :user, "user"
set :password, "password"
set :host, "server_ip"
set :domain, "domain.com"
set :application, "app_name"

set :repository, "git://dburnsdesign.com/repos/mainline.git"
set :branch,     "origin/master"
# =============================================================================
# NAO MEXER DAQUI PARA BAIXO
# =============================================================================
role :web, host
role :app, host
role :db,  host

set :deploy_to, "/home/#{user}" 

set :scm, :git

set :current_release, 

ssh_options[:username] = user
ssh_options[:paranoid] = false
# =============================================================================
# TAREFAS - NAO MEXER A MENOS QUE SAIBA O QUE ESTA FAZENDO
# =============================================================================

desc "send config files to server"
task :before_setup do
  
  run "test -d #{deploy_to}/etc || mkdir -m 755 #{deploy_to}/etc"
  upload File.join(File.dirname(__FILE__), "templates/database.yml"), "#{deploy_to}/etc/database.yml"
  upload File.join(File.dirname(__FILE__), "templates/backup.rb"), "#{deploy_to}/etc/backup.rb"
  upload File.join(File.dirname(__FILE__), "templates/ssh_helper.rb"), "#{deploy_to}/etc/ssh_helper.rb"
  
end

namespace :deploy do
  desc "Restart with Passenger"
  task :restart, :roles => :app do
    run "touch #{deploy_to}/current/tmp/restart.txt"
  end
 
  desc "Setup a GitHub-style deployment."
  task :setup, :except => { :no_release => true } do
    run "git clone #{repository} #{current_path}"
    run "test -d #{current_path}/tmp || mkdir -m 755 #{current_path}/tmp"
    run "test -d #{current_path}/db || mkdir -m 755 #{current_path}/db"
  end
 
  desc "Update the deployed code."
  task :update_code, :except => { :no_release => true } do
    run "cd #{current_path}; git fetch origin; git reset --hard #{branch}"
  end
 
  desc "check if the configurations files are present"
  task :symlink do
    on_rollback {}
    run <<-CMD
      rm -rf #{current_path}/log #{current_path}/public/system #{current_path}/tmp/pids #{current_path}/config/database.yml &&
      ln -s #{shared_path}/log #{current_path}/log &&
      ln -s #{shared_path}/system #{current_path}/public/system &&
      ln -s #{shared_path}/pids #{current_path}/tmp/pids &&
      ln -s #{deploy_to}/etc/database.yml #{current_path}/config/database.yml &&
      cd #{current_path} && rake db:migrate RAILS_ENV=production
    CMD
  end

  namespace :rollback do
    task :default do
      revision
      restart
    end
    
    desc "Rollback a single commit."
    task :revision, :except => { :no_release => true } do
      set :branch, "HEAD^"
      default
    end
  end

end

namespace :log do
  desc "tail production log files" 
  task :tail, :roles => :app do
    run "tail -f #{shared_path}/log/production.log" do |channel, stream, data|
      puts  # para uma linha extra 
      puts "#{channel[:host]}: #{data}" 
      break if stream == :err    
    end
  end
end

namespace :db do
  desc "Faz o backup remoto e download do banco de dados MySQL"
  task :backup, :roles => :db do
    backup_rb ||= "#{deploy_to}/etc/backup.rb"
    run "if [ -f #{backup_rb} ]; then ruby #{backup_rb} backup #{deploy_to} ; fi"
    get "#{deploy_to}/etc/dump.tar.gz", "dump.tar.gz"
    run "rm #{deploy_to}/etc/dump.tar.gz"
  end
  
  desc "Faz o upload e o restore remoto do banco de dados MySQL"
  task :restore, :roles => :db do
    unless File.exists?("dump.tar.gz")
      puts "Backup dump.tar.gz nao encontrado"
      exit 0
    end
    backup_rb ||= "#{deploy_to}/etc/locaweb_backup.rb"
    upload "dump.tar.gz", "#{deploy_to}/etc/dump.tar.gz"
    run "if [ -f #{backup_rb} ]; then ruby #{backup_rb} restore #{deploy_to} ; fi"
  end
  
  desc "Apaga todas as tabelas do banco de dados [CUIDADO! OPERACAO SEM VOLTA!]"
  task :drop_all, :roles => :db do
    backup_rb ||= "#{deploy_to}/etc/backup.rb"
    run "if [ -f #{backup_rb} ]; then ruby #{backup_rb} drop_all #{deploy_to} ; fi"
  end
end