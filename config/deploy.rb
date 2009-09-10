set :stages, %w(nokia production)
set :default_stage, "production"
require 'capistrano/ext/multistage'

default_run_options[:pty] = true
set :spinner_user, nil
set :runner, :yruser
set :repository,  "git@github.com:wolas/progress.git"
set :user, :yruser
set :branch, "master"
set :use_sudo, true

set :scm, :git
set :scm_username, "wolas"
set :scm_passphrase, "deploypassword"

server "152.146.39.15", :app, :web, :db, :primary => true

namespace :deploy do
  task :restart do
    run "sudo -p 'sudo password: ' god restart progress"
  end
end
