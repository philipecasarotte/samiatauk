# =============================================================================
# CONFIGURE OS VALORES DE ACORDO COM SUA HOSPEDAGEM
# =============================================================================
set :user, "user"
set :password, "password"
set :host, "server_ip"
set :domain, "domain.com"
set :application, "app_name"

set :repository, "git://dburnsdesign.com/repos/mainline.git"
# =============================================================================
# NAO MEXER DAQUI PARA BAIXO
# =============================================================================
role :web, host
role :app, host
role :db,  host

set :deploy_to, "/home/#{user}" 
set :public_html, "/home/#{user}/public_html"
set :current_deployment, "#{deploy_to}/current"

set :runner, nil
set :use_sudo, false

set :scm, :git

set :keep_releases, 3

ssh_options[:username] = user
ssh_options[:paranoid] = false
# =============================================================================
# TAREFAS - NAO MEXER A MENOS QUE SAIBA O QUE ESTA FAZENDO
# =============================================================================
desc "Garante que o database.yml foi corretamente configurado"
task :before_symlink do
  on_rollback {}
  run "test -d #{release_path}/tmp || mkdir -m 755 #{release_path}/tmp"
  run "test -d #{release_path}/db || mkdir -m 755 #{release_path}/db"
  run "cp #{deploy_to}/etc/database.yml #{release_path}/config/database.yml"
  run "cd #{release_path} && rake db:migrate RAILS_ENV=production"
end

desc "Garante que as configuracoes estao adequadas"
task :before_setup do
  ts = Time.now.strftime("%y%m%d%H%M%S")
  
  upload File.join(File.dirname(__FILE__), "templates/database.yml"), "#{deploy_to}/etc/database.yml"
  upload File.join(File.dirname(__FILE__), "templates/backup.rb"), "#{deploy_to}/etc/backup.rb"
  upload File.join(File.dirname(__FILE__), "templates/ssh_helper.rb"), "#{deploy_to}/etc/ssh_helper.rb"
  
end

desc "Prepare the production database before migration"
task :before_cold do
end

namespace :deploy do
  desc "Pede restart ao servidor Passenger"
  task :restart, :roles => :app do
    run "touch #{deploy_to}/current/tmp/restart.txt"
  end
end

[:start, :stop].each do |t|
    desc "A tarefa #{t} nao eh necessaria num ambiente com Passenger"
    task t, :roles => :app do ; end
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

after "deploy:update", "deploy:cleanup"