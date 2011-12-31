$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require "rvm/capistrano"
set :rvm_ruby_string, 'ruby-1.9.2-p290'
set :rvm_type, :user
require "bundler/capistrano"
set :application, "reservas"
set :domain, "tienda_galiclick.galiclick.com"
set :user, "galiclick"
set :port, 58378
set :repository,  "git@github.com:jgamsan/managebooks.git"
default_run_options[:pty] = true

set :scm, :git

default_run_options[:pty] = true
set :use_sudo, false
set :deploy_via, :remote_cache
set :deploy_to, "/home/#{user}/public_html/#{application}"
role :web, domain
role :app, domain
role :db,  domain, :primary => true

set :rails_env, "production"

namespace :deploy do
  task :start do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  task :stop do end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
after 'deploy:update_code' do
  run "cd #{release_path}; RAILS_ENV=production bundle exec rake assets:precompile"
end
after "deploy", "deploy:cleanup"

