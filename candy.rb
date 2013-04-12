# Candy assets

repo = "https://raw.github.com/o_ame/candy-assets/master"
gems = {}
@app_name = app_name
@use_bootstrap = yes?("Install Twitter-Bootstrap?") ? true : false

comment_lines 'Gemfile', "gem 'sqlite3'"
comment_lines 'Gemfile', "gem 'jquery-rails'"
uncomment_lines 'Gemfile', "gem 'therubyracer'"

gem 'devise'
gem 'omniauth'
gem 'omniauth-twitter'
gem 'i18n_generators'
gem 'whenever', require => false
gem 'slim'
gem 'slim-rails'
gem 'kaminari' if yes?('Install kaminari?')

gem_group :production do
  gem 'libv8'#, '~> 3.11.8'
  gem 'execjs'
  gem 'therubyracer'
  gem 'mysql'
end

gem_group :development do
  gem 'foreman'
  
  # Improve error analytics
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'sqlite3'
end

gem_group :test do
  gem 'rspec-rails'
  gem 'spork-rails'
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'faker'
  gem 'factory_girl_rails'
  gem 'rb-fsevent'
  gem 'guard-spork'
  gem 'guard-rspec'
  gem 'growl'
end

gem_group :deployment do
  gem 'capistrano'
  gem 'capistrano-ext'
end

gem_group :assets do
  gem 'compass'
  gem 'compass-rails'
  gem 'twitter-bootstrap-rails' if @use_bootstrap
end

# mongodb
gems[:mongodb] = yes?("Use MongoDB?")
if gems[:mongodb]
  gem 'mongo'
end

# bundle install
run "bundle install"

# capify application
capify!

# Capfile
uncomment_lines "Capfile", "load 'deploy/assets'"

# Remove file
remove_file "public/index.html"
remove_file "app/views/layouts/application.html.erb"

# locales/ja.yml
get "#{repo_url}/config/locales/ja.yml", "config/locales/ja.yml"

# helpers
remove_file "app/helpers/application_helper.rb"
get "#{repo_url}/app/helpers/application_helper.rb", "app/helpers/application_helper.rb"

if @use_bootstrap
  # bootstrap
  generate 'bootstrap:install'

  if yes?("Would you like to create FIXED layout?(yes=FIXED, no-FLUID)")
    generate 'bootstrap:layout application fixed'
  else
    generate 'bootstrap:layout application fluid'
  end

  gsub_file "app/views/layouts/application.html.slim", /lang="en"/, %(lang="ja") 
end

# rspec
generate 'rspec:install'