require 'bundler/capistrano'
require "capistrano-rbenv"
require "delayed/recipes"

set :whenever_command, "bundle exec whenever"
set :whenever_environment, defer { stage }
set :whenever_identifier, defer { "#{application}" }
require "whenever/capistrano"

# rbenv stuff
set :default_environment, {
  'PATH' => "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"
}
set :bundle_flags, "--deployment --quiet --binstubs --shebang ruby-local-exec"

set :stages, %w(production staging)
set :default_stage, "staging"
require 'capistrano/ext/multistage'

set :rbenv_ruby_version, "2.1.2"

set :user, "rails"
set :application, "fat_free_crm"
set :deploy_to, "/home/#{user}/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false
set :scm, "git"
set :scm_verbose, true
set :repository, "git@bitbucket.org:tzubyak/icecondos-crm.git"
set :branch, ENV['BRANCH'] ? ENV['BRANCH'] : "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

def template(from, to)
  erb = File.read(File.expand_path("../recipes/templates/#{from}", __FILE__))
  put ERB.new(erb).result(binding), to
end

load "config/recipes/unicorn"

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
  end

  desc "Symlink config files."
  task :symlink_configs do
    run "ln -nfs #{shared_path}/config/database.yml #{latest_release}/config/database.yml"
  end
end

before "deploy:finalize_update", "deploy:symlink_configs"
after "deploy", "deploy:cleanup" # keep only the last 5 releases
after "deploy:stop",    "delayed_job:stop"
after "deploy:start",   "delayed_job:start"
after "deploy:restart", "delayed_job:restart"
