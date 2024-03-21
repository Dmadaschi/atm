# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.3.0'

gem 'bootsnap', require: false
gem 'puma', '>= 5.0'
gem 'rails', '~> 7.1.3', '>= 7.1.3.2'
gem 'sqlite3', '~> 1.4'
gem 'tzinfo-data', platforms: %i[windows jruby]
gem 'active_model_serializers'

group :development, :test do
  gem 'debug', platforms: %i[mri windows]
  gem 'pry', '~> 0.14.2'
  gem 'rspec-rails', '~> 6.1.0'
  gem 'rubocop'
  gem 'rubocop-rails'
end

group :test do
  gem 'factory_bot_rails'
  gem 'simplecov', require: false
end
