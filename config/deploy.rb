default_run_options[:pty] = true
set :spinner_user, nil
set :runner, :yruser
set :application, "progress"
set :repository,  "git@github.com:wolas/progress.git"
set :user, :yruser
set :passphrase, 'yrpassword'
set :deploy_to, "/home/yruser/apps/#{application}"
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
