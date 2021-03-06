require "bundler/capistrano"
require "rvm/capistrano"                # Load RVM's capistrano plugin.

server "oggy.jnaqsh.com", :web, :app, :db, primary: true

set :application, "farsi_textcaptcha"
set :user, "deployer"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false
set :rvm_ruby_string, '1.9.3-p362'

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

  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
  end

  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    run "mkdir -p #{shared_path}/config"
    put File.read("config/database.yml.sample"), "#{shared_path}/config/database.yml"
    put File.read("config/textcaptcha.yml.sample"), "#{shared_path}/config/textcaptcha.yml"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/textcaptcha.yml #{release_path}/config/textcaptcha.yml"
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

  before "bundle:install" do
    run "cd #{fetch(:latest_release)} && bundle config build.pg --with-pg-config=/usr/pgsql-9.2/bin/pg_config"
  end

  before "deploy", "deploy:check_revision"
end
