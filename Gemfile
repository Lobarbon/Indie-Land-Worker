# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }
# ruby '2.7.2'

# Web Application
gem 'erubi', '~> 1.5' # Template syntax
gem 'puma', '~> 3.11' # a multi-threaded, multi-processing server
gem 'roda', '~> 3.8' # web app framework
gem 'tilt', '~> 2.0.6' # Template engine

# Type validation
gem 'dry-struct', '~> 1.3'
gem 'dry-types', '~> 1.4'

# Networking
gem 'http', '~>4.0'

# Utilities
gem 'econfig', '~>2.1' # easily configure
gem 'rake', '~>13.0' # we can say that rake is Ruby's makefile

# Object-Relational Mapping
gem 'sequel', '~>1.4' # ORM lib

group :development, :test do
  # Testing
  gem 'minitest', '~>5.0'
  gem 'minitest-rg', '~>5.0'
  gem 'simplecov', '~>0'
  gem 'vcr', '~> 6.0'
  gem 'webmock', '~> 3.0'

  # Code Quality, Getting the latest version is fine
  gem 'flog'
  gem 'reek'
  gem 'rubocop'

  # Utilities
  gem 'pry' # a debugging sandbox

  # Local database
  gem 'database_cleaner', '~>1.8'
  gem 'sqlite3', '~> 1.4'

  # display pretty db records
  gem 'hirb', '~> 0.7'
end
