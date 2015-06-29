source 'https://rubygems.org'

ruby '2.1.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.3'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

gem 'ace-rails-ap', github: 'dedico/ace-rails-ap'

gem 'flatstrap-sass'

gem 'jquery-fileupload-rails', github: 'demiazz/jquery-fileupload-rails'

gem 'shared-mime-info'

gem 'launchy'

gem 'haml-rails'

gem 'jquery-ui-rails'

gem 'backbone-on-rails'

gem 'nokogiri'

gem 'settingslogic'

gem 'acts-as-taggable-on', '~> 3.4'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

group :production do
  # Use mysql as the database for Active Record
  gem 'mysql2'

  gem 'rails_12factor'
  gem 'unicorn', platforms: :ruby
end

group :development do
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-commands-teaspoon'
  gem 'guard-rspec', require: false
  gem 'guard-livereload', require: false
  gem 'guard-rubocop', require: false
  gem 'terminal-notifier-guard', require: false
end

group :development, :test do
  gem 'sqlite3'
  gem 'commands'
  gem 'rubocop'
  gem 'rspec-rails'
  gem 'teaspoon'
  gem 'smalruby', '~> 0.1.10', require: false
end

group :test do
  gem 'shoulda-matchers'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'poltergeist'
  gem 'turnip'
  gem 'coveralls', require: false
  gem 'json_spec'
  gem 'database_rewinder'
end
