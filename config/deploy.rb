# require 'hoptoad_notifier/capistrano'

# This defines a deployment "recipe" that you can feed to capistrano
# (http://manuals.rubyonrails.com/read/book/17). It allows you to automate
# (among other things) the deployment of your application.

# =============================================================================
# REQUIRED VARIABLES
# =============================================================================
# You must always specify the application and repository for every recipe. The
# repository must be the URL of the repository you want this recipe to
# correspond to. The deploy_to path must be the path on each machine that will
# form the root of the application path.

set :application, "peer_review"
# set :repository, "http://svn.uscm.org/#{application}/trunk"
set :repository,  "git@git.26am.com:ccc360.git"
# set :checkout, 'co'
set :keep_releases, '3'

# =============================================================================
# ROLES
# =============================================================================
# You can define any number of roles, each of which contains any number of
# machines. Roles might include such things as :web, or :app, or :dbl. defining
# what the purpose of each machine is. You can also specify options that can
# be used to single out a specific subset of boxes in a particular role, like
# :primary => true.
set :target, ENV['target'] || ENV['TARGET'] || 'dev'
default_run_options[:pty] = true
set :scm, "git"
case target
when 'dev'
  role :app, "172.16.1.25"
  role :db, "172.16.1.25", :primary => true
  set :deploy_to, "/var/www/html/integration/pr"
  set :app_port, 4110
  set :user, 'deploy'
  set :password, 'alt60m'
  set :rails_env, 'development'
  set :branch, "master"
when 'prod'
  role :app, "172.16.1.25"
  role :app, "172.16.1.25"
  set :deploy_to, "/var/www/html/production/pr"
  set :app_port, 4120
  set :user, 'deploy'
  set :password, 'alt60m'
  set :rails_env, 'production'
  # set :branch, "master"
  set :branch, "master"
  # set :deploy_via, :copy
# set :copy_cache, true
# set :copy_exclude, [".git","coverage"]

# set :scm_passphrase, "p@ssw0rd" #This is your custom users password
when 'slice'
  role :app, "mt.ministryhacks.com"
  role :db, "mt.ministryhacks.com", :primary => true
  set :deploy_to, "/var/www/mt.ministryhacks.com"
  set :rails_env, 'production'
end

# define the restart task
desc "Restart the web server"
deploy.task :restart, :roles => :app do
  run "touch #{deploy_to}/current/tmp/restart.txt"
end  

ssh_options[:forward_agent] = true
ssh_options[:port] = 40022

# set :branch, "master"
set :deploy_via, :remote_cache
set :git_enable_submodules, 1



desc "Add linked files after deploy and set permissions"
task :after_update_code, :roles => :app do
  begin
  run "ln -s #{shared_path}/coverage #{release_path}/public/coverage"
  rescue; end;
  begin
  run "ln -s #{release_path}/doc/app #{release_path}/public/doc"
  rescue; end;
  begin
  # run "ln -s #{shared_path}/system/payment.yml #{release_path}/config/payment.yml"
  rescue; end;
  begin
  run "ln -s #{shared_path}/config/base_url.txt #{release_path}/config/base_url.txt"
  rescue; end;
 # ln -s #{shared_path}/config/cache_money.rb #{release_path}/config/initializers/cache_money.rb

  # ln -s #{shared_path}/config/cmt_config.rb #{release_path}/config/initializers/cmt_config.rb &&

  run <<-CMD 
    ln -s #{shared_path}/config/database.yml #{release_path}/config/database.yml &&
    mkdir -p -m 770 #{shared_path}/tmp/{cache,sessions,sockets,pids} &&
    rm -Rf #{release_path}/tmp &&
    ln -s #{shared_path}/tmp #{release_path}/tmp
  CMD
  
  run "cd #{release_path} && git submodule init"
  run "cd #{release_path} && git submodule update"
end

desc "Automatically run cleanup"
task :after_deploy, :roles => :app do
  deploy.cleanup
end
