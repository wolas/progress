set :application, "nokia_progress"
set :deploy_to, "/home/yruser/apps/#{application}"

namespace :deploy do
  task :create_logs do
    run ""
  end
end