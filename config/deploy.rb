require "rvm/capistrano"
set :rvm_ruby_string, 'ruby-1.9.3-p125'
require "bundler/capistrano"
set :application, "reservas"
set :domain, "mail.galiclick.com"
set :user, "galiclick"
set :repository,  "git@github.com:jgamsan/managebooks.git"
set :scm, :git

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :use_sudo, false
set :deploy_via, :remote_cache
set :deploy_to, "/home/galiclick/public_html/#{application}"
set :rails_env, "production"
set :keep_releases, 2
task :demo do
  role :web, "#{domain}:53877"
  role :app, "#{domain}:53877"
  role :db,  "#{domain}:53877", :primary=>true
end

task :main do
  role :web, "#{domain}:58378"
  role :app, "#{domain}:58378"
  role :db,  "#{domain}:58378", :primary=>true
end

namespace :customs do
  task :symlink, :roles => :app do
    run "ln -nfs #{shared_path}/system/uploads #{release_path}/public"
  end
end
after "deploy:create_symlink","customs:symlink"
after "deploy", "deploy:cleanup"
require 'capistrano-unicorn'

