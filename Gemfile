source 'https://rubygems.org'

gem 'rails', '3.2.11'
gem 'sqlite3'
gem 'devise'
gem 'omniauth'
gem 'omniauth-twitter'
gem 'i18n_generators'

group :production do
  gem 'libv8', '~> 3.11.8'
  gem 'execjs'
  gem 'therubyracer'
end

group :development, :test do
  gem 'foreman'
  
  # Improve error analytics
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :test do
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

group :deployment do
  gem 'capistrano'
  gem 'capistrano-ext'
end

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'compass'
  gem 'compass-rails'
end

gem "jquery-rails"
gem "slim"
gem "slim-rails"
#gem 'rack-jsonp-middleware', :require => 'rack/jsonp'
