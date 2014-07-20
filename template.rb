repo_url = "https://raw.githubusercontent.com/oame/rails-template/master"

config = {}
config[:deploy_with_docker] = yes?("Would you like to deploy into Docker?")
config[:install_devise] = yes?("Would you like to install Devise?")

remove_file 'README.rdoc'
create_file 'README.md', "# #{app_name}"

remove_file 'public/favicon.ico'
remove_file 'public/robots.txt'

inject_into_file '.gitignore', after: %{/.bundle} do
  "\n/vendor/bundle"
end

## Gemfile
remove_file 'Gemfile'
create_file 'Gemfile' do <<-GEMFILE
source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '#{Rails::VERSION::STRING}'

gem 'slim-rails'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'compass-rails'
gem 'ceaser-easing'

# Gems
  GEMFILE
end

inject_into_file 'Gemfile', after: %{source 'https://rubygems.org'} do
  "\nruby '#{RUBY_VERSION}'\n"
end

gem 'figaro'
gem 'devise' if config[:install_devise]
gem 'cancancan'
gem 'paranoia'
gem 'gravatar_image_tag'
gem 'turbolinks'
gem 'jquery-turbolinks'
gem 'nprogress-rails'
gem 'rabl'
gem 'oj'
gem 'action_args'
gem 'newrelic_rpm'
gem 'rails_admin'

if config[:deploy_with_docker]
  gem_group :production do
    gem 'pg'
    gem 'rails_12factor'
  end

  gsub_file 'config/database.yml', /production\:.+[\n\n|\z]/m do <<-EOD
production:
  adapter: postgresql
  host: <%= ENV['POSTGRES_PORT_5432_TCP_ADDR'] %>
  port: <%= ENV['POSTGRES_PORT_5432_TCP_PORT'] %>
  encoding: utf8
  database: <%= ENV['POSTGRES_ENV_POSTGRESQL_DB'] %>
  pool: 5
  username: <%= ENV['POSTGRES_ENV_POSTGRESQL_USER'] %>
  password: <%= ENV['POSTGRES_ENV_POSTGRESQL_PASS'] %>
    EOD
  end
end

gem_group :development, :test do
  gem 'sqlite3'
  gem 'quiet_assets'
  gem 'meta_request'
  gem 'annotate'
  gem 'spring'
  gem 'spring-commands-rspec'

  # Test
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'faker-japanese'
  gem 'capybara'
  gem 'database_cleaner'

  # Improve error analytics
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'pry-rails'
  gem 'hirb'
  gem 'hirb-unicode'
  gem 'awesome_print'
  gem 'tapp'

  # Detect vulnerability
  gem 'brakeman', require: false

  # Detect N+1
  gem 'bullet'
end

run "bundle install --path vendor/bundle --binstubs .bundle/bin --without production -j4"

generate "figaro:install"
generate "rspec:install"
gsub_file ".rspec", "--warnings\n", ""

if config[:install_devise]
  generate "model user name:string"
  generate "devise:install"
  generate "devise user"
  generate "devise:views users"
end

## erb2slim
run "if which erb2slim > /dev/null; then erb2slim -d app/views; fi"

## js2coffee
run "if which js2coffee > /dev/null; then (js2coffee app/assets/javascripts/application.js > app/assets/javascripts/application.js.coffee) && rm app/assets/javascripts/application.js; fi"

## sass-convert
run "if which sass-convert > /dev/null; then (sass-convert -T scss app/assets/stylesheets/application.css > app/assets/stylesheets/application.css.scss) && rm app/assets/stylesheets/application.css; fi"

## locales/ja.yml
get "https://raw.github.com/svenfuchs/rails-i18n/master/rails/locale/ja.yml", "config/locales/ja.yml"

## --skip-bundle
def run_bundle ; end
