# encoding: utf-8

#set :branch, 'stging'
set :rails_env, 'staging'
set :deploy_to, "/var/www/#{application}"

role :web, ''
role :app, ''
role :db, '', :primary => true # rake:db:migrateを実行するサーバ