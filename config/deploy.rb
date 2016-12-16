# frozen_string_literal: true
# config valid only for current version of Capistrano
lock '3.7.0'

set :application, 'spa_backend'
set :repo_url, 'git@github.com:rkotov93/spa_backend.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/home/ubuntu/applications/spa_backend'

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
append :linked_files, 'config/database.yml', 'config/application.yml'

# Default value for linked_dirs is []
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :puma_bind,       "unix:/home/ubuntu/applications/spa_backend/shared/tmp/sockets/puma.sock"
set :puma_state,      "/home/ubuntu/applications/spa_backend/shared/tmp/pids/puma.state"
set :puma_pid,        "/home/ubuntu/applications/spa_backend/shared/tmp/pids/puma.pid"
set :puma_access_log, "/home/ubuntu/applications/spa_backend/releases/log/puma.error.log"
set :puma_error_log,  "/home/ubuntu/applications/spa_backend/releases/log/puma.access.log"
set :puma_init_active_record, true

# Configure rvm
set :rvm_type, :user
set :rvm_ruby_version, '2.3.1'
