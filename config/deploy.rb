require 'capistrano/ext/multistage'

set :application, "" # ApplicationName
set :repository,  ""
set :scm, :git

set :user, "root"
ssh_options[:port] = "10122"

role :local, "localhost"
#role :web, "49.212.172.252"                          # Your HTTP server, Apache/etc
#role :app, "49.212.172.252"                          # This may be the same as your `Web` server
#role :db,  "49.212.172.252", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

# ommit upgrade and asset folders
set :normalize_asset_timestamps, false

# releaseフォルダ内の古いソースコードは過去３つ分まで
set :keep_releases, 3

# sudoを使うかどうか
set :use_sudo, true

# cap deploy:setup 後、/var/www/App の権限変更
namespace :setup do
  task :fix_permissions do
    sudo "chown -R #{user}.#{user} #{deploy_to}"
  end
end
after "deploy:setup", "setup:fix_permissions"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end