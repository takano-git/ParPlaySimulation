source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'
gem 'rails', '~> 5.2.4', '>= 5.2.4.4'
gem 'sqlite3'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'bootsnap', '>= 1.1.0', require: false

# ログイン機能
gem 'devise', git: "https://github.com/heartcombo/devise"
gem 'omniauth-google-oauth2'
gem "omniauth-rails_csrf_protection"

# 日本語化
gem 'rails-i18n', '~> 5.1'
gem 'devise-i18n'

# Bootstrap
gem 'bootstrap', '~> 4.5'
gem 'jquery-rails'
gem 'devise-bootstrap-views', '~> 1.0'
gem 'data-confirm-modal'

# ActiveStorageバリデーション
gem 'active_storage_validations', '~> 0.8.8'

# AWS S3用SDK
gem 'aws-sdk-s3', '~>1', require: false
gem 'mini_magick'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
