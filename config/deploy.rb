server 'ec2-54-93-67-200.eu-central-1.compute.amazonaws.com', user: 'ubuntu', roles: %w{web app db}

#role :all, %w{deploy@ec2-54-93-67-200.eu-central-1.compute.amazonaws.com}
set :application, 'applikey-test-task'
set :repo_url, 'git@github.com:MrBelousov/applikey-test-task.git'
set :port, 80
set :stages, %w(production staging)
set :deploy_to, "/home/ubuntu/apps/applikey-test-task"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :branch, "master"

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

after 'deploy:publishing', 'deploy:restart'

namespace :deploy do

  desc 'Start application'
  task :start do
    on roles(:app) do
      execute "sudo /etc/init.d/unicorn_#{fetch :application} start"
    end
  end

  task :restart do
    invoke 'unicorn:restart'
  end
end

