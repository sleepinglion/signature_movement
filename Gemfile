source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.6'
# Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 1.4'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Use Active Storage variant
#gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false
gem 'bootstrap', '~> 5.3.1'
gem 'sprockets', '~> 3.7.2'
gem 'devise'
gem 'cancancan'
gem 'kaminari'
gem 'carrierwave', '~> 2.0'
gem 'mini_magick'
gem 'sitemap_generator'
gem 'meta-tags'
gem 'gretel'
gem 'nokogiri', '>= 1.12.5'
gem 'impressionist'
gem 'jquery-rails'
gem 'sassc-rails'
gem 'i18n-js'
gem 'trix'
gem 'acts_as_votable'
gem 'acts-as-taggable-on'

gem 'omniauth'
gem 'oauth2', '1.4.11'
gem 'omniauth-oauth2'
gem 'omniauth-rails_csrf_protection'
gem 'omniauth-facebook'
gem 'omniauth-naver'
gem 'omniauth-google-oauth2'
gem 'omniauth-kakao', path: "lib/omniauth-kakao"
gem 'omniauth-apple'
gem 'omniauth-twitter'
gem 'omniauth-github'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # Capistrano
  gem 'capistrano'
  gem 'capistrano-rbenv'
  gem 'capistrano-nvm'
  gem 'capistrano-npm'
  gem 'capistrano-bundler'
  gem 'capistrano-passenger'
  gem 'capistrano-rails'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

group :production do
  gem 'asset_sync'
  gem 'fog-azure-rm', git: 'https://github.com/sleepinglion/fog-azure-rm'
  gem 'mysql2', '>=0.5.5'
  gem 'redis'
  gem 'redis-store', '1.9.1'
  gem 'dotenv-rails'
  gem 'recaptcha', :require => 'recaptcha/rails'
  gem 'rails-letsencrypt'
  gem 'uglifier'

  #gem 'mini_racer', platforms: :ruby
  #gem 'execjs'

  # Redis Cache
  gem 'redis-rails'
  gem 'redis-rack-cache'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
#gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

