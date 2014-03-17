source 'https://rubygems.org'

gem 'rails', '3.2.17'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :development do
  gem 'sqlite3'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.6'
  gem 'coffee-rails', '~> 3.2.2'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '~> 2.5.0'
end

group :production do
  gem 'execjs'
  gem 'mysql2'
end

# for scheduling jobs
gem 'whenever', :require => false

gem 'jquery-rails'
gem 'virastar'
gem "therubyracer"
gem "less-rails" #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
gem 'twitter-bootstrap-rails', :git => 'git@github.com:jnaqsh/twitter-bootstrap-rails.git'

gem 'rails-i18n', git: 'https://github.com/iCEAGE/rails-i18n.git'

gem 'nested_form', :git => 'https://github.com/ryanb/nested_form.git'
gem 'simple_form'
gem 'active_link_to'
gem 'acts_as_textcaptcha', git: "https://github.com/jnaqsh/acts_as_textcaptcha.git"
gem 'meta-tags', :require => 'meta_tags'
gem 'gabba'

group :test, :development do
  gem "rspec-rails"
end

group :test do
  gem 'capybara'
  gem 'shoulda-matchers'
end

# To use ActiveModel has_secure_password
 gem 'bcrypt-ruby', '~> 3.0.0'

# for maintenance page in capistrano
#gem "capistrano-maintenance"

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano

group :development do
  gem 'capistrano-rails', '~> 1.0.0'
  gem 'capistrano-rbenv', '~> 2.0'
  gem 'capistrano-bundler', '~> 1.1.2'
end

# To use debugger
# gem 'debugger'
