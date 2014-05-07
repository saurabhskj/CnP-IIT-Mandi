source 'http://rubygems.org'

gem 'rails', '3.2.16'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'
#
gem 'pg'
gem 'rubyzip'
if defined?(JRUBY_VERSION)
    gem 'activerecord-jdbc-adapter', :require => false
    gem 'jdbc-sqlite3', :require => false
    gem 'jruby-openssl'
    gem 'activerecord-jdbcmysql-adapter'
    gem 'activerecord-jdbcpostgresql-adapter'
    #gem 'jdbc-postgres'
    gem 'therubyrhino'
    # See https://github.com/sstephenson/execjs#readme for more supported runtimes
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

	gem 'jbuilder'
  gem 'uglifier', '>= 1.0.3'
  #gem 'zurb-foundation' #, :git => "git://github.com/zurb/foundation.git"
end

gem 'carrierwave'

# 
gem 'foundation-rails'
gem 'aws-ses'

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'devise'
gem 'capybara'


gem 'acts-as-taggable-on'
gem 'rails3-jquery-autocomplete'

gem 'omniauth'
gem 'will_paginate'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
#gem 'turbolinks'

group :development do
  gem 'puma'
  gem "better_errors"
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
 gem 'capistrano', '2.15.2'
 gem 'capistrano-ext'
# To use debugger
# gem 'debugger'
