source "https://rubygems.org"

# Use main development branch of Rails
gem "rails", github: "rails/rails", branch: "main"
# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"
# Use sqlite3 as the database for Active Record
gem "sqlite3", ">= 1.4"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"
# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"
# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# gem "sentry-ruby"
# gem "sentry-rails"

# Data handling and validation
# gem "countries"
gem "addressable"
gem "hashie", "~> 5.0"
gem "dry-schema", "~> 1.13"

# AI/ML Integration
gem "ruby-openai", "~> 7.3"
gem "langchainrb", "~> 0.19.1"

gem "concurrent-ruby", require: "concurrent"
gem "concurrent-ruby-edge", "~> 0.7.2", require: "concurrent/edge/promises"

gem "faraday"
gem "faraday-follow_redirects"
gem "httpx", "~> 1.3"
gem "ostruct"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", require: false
  gem "pry"
end

# gem "mission_control-jobs", "~> 1"
# gem "hotwire_combobox", "~> 0.3.2"
# gem "i18n_data", "~> 1.1"
# gem "sanitize"
# gem "oj", "~> 3.16"

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
  gem "minitest-snapshots"
  gem "webmock", "~> 3.24"
  gem "vcr", "~> 6.3"
end

gem "tailwindcss-rails", "~> 3.1"

gem "dockerfile-rails", ">= 1.7", group: :development

gem "redis", "~> 5.3"

gem "sentry-ruby"
gem "sentry-rails"

gem "aws-sdk-s3", "~> 1.177", require: false
gem "ruby-vips"

gem "kaminari", "~> 1.2"

gem "chronic", "~> 0.10.2"
