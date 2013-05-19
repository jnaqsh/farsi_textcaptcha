require "bundler/capistrano"
require 'capistrano/maintenance'

set :whenever_command, "bundle exec whenever"
set :whenever_environment, defer { "production" }
require "whenever/capistrano"

server "server.jnaqsh.com", :web, :app, :db, primary: true

set :application, "farsi_textcaptcha"
set :user, "deployer"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

# rbenv
set :default_environment, {
  "PATH" => "/home/#{user}/.rbenv/shims:/home/#{user}/.rbenv/bin:$PATH",
}

set :scm, "git"
set :repository, "git@github.com:jnaqsh/#{application}.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases

namespace :deploy do
  desc "reload the database with seed data"
  task :seed do
    run "cd #{current_path}; bundle exec rake db:seed RAILS_ENV=#{rails_env}"
  end

  desc 'Start Application'
  task :start, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end

  desc 'Restart Application'
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join current_path,'tmp','restart.txt'}"
  end

  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /opt/nginx/sites-enabled/#{application}"
    run "mkdir -p #{shared_path}/config"
    run "mkdir -p #{shared_path}/db_backup"
    put File.read("config/database.yml.sample"), "#{shared_path}/config/database.yml"
    put File.read("config/textcaptcha.yml.sample"), "#{shared_path}/config/textcaptcha.yml"
    put File.read("config/dropbox.example.yml"), "#{shared_path}/config/dropbox.yml"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/textcaptcha.yml #{release_path}/config/textcaptcha.yml"
    run "ln -nfs #{shared_path}/config/dropbox.yml #{release_path}/config/dropbox.yml"
    run "ln -nfs #{shared_path}/db_backup #{release_path}/db/db_backup"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end

  before "deploy", "deploy:check_revision"
end
