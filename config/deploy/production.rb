# encoding: utf-8

#set :branch, 'prod'
set :rails_env, 'production'
set :deploy_to, "/var/www/#{application}"

role :web, ''
role :app, ''
role :db, '', :primary => true # rake:db:migrateを実行するサーバ