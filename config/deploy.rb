# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'xincheping'
set :repo_url, 'git@github.com:swachian/xincheping.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/opt/deploy/xincheping'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')
 set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets')

# Default value for default_env is {}
set :default_env, { path: "/home/zhangyu/.rbenv/versions/ruby-2.3/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  task :restart_server do
    on roles(:web) do
      within current_path do
        with rails_env: fetch(:rails_env), rails_relative_url_root: '/xincheping' do
          execute :rake, 'thin:restart', env: {rails_env: fetch(:rails_env) }
        end
      end
    end
  end
  after "deploy:published", "restart_server"

end
