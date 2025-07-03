# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../dummy/config/environment', __FILE__)
require 'rspec/rails'
# require 'rspec/autorun' # Deprecated in modern RSpec

# Needed in rails4 to run specs, see https://github.com/activeadmin/activeadmin/issues/2712#issuecomment-46798603
require_relative 'dummy/app/admin/articles'
require_relative 'dummy/app/admin/admin_users'
require_relative 'dummy/app/admin/dashboard'
require_relative 'dummy/config/routes'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# `brew install phantomjs` to make it working
# require 'capybara/poltergeist' # Deprecated, replaced with selenium
# Capybara.javascript_driver = :poltergeist # Deprecated

# Modern Capybara setup for Rails 7
require 'selenium/webdriver'
require "capybara/rspec"

# Enable verbose logging for selenium-webdriver
Selenium::WebDriver.logger.level = :debug
Selenium::WebDriver.logger.output = 'selenium.log'

Capybara.register_driver :selenium_chrome_headless do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless')
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-dev-shm-usage')
  options.add_argument('--disable-gpu') # Added to prevent issues with headless browser startup in WSL
  options.add_argument('--disable-features=VizDisplayCompositor') # Added to prevent browser startup crashes in WSL
  options.add_argument('--disable-extensions')
  options.add_argument('--remote-debugging-port=9222')

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.javascript_driver = :selenium_chrome_headless

# save screenshots and html of failed js tests
require 'capybara-screenshot/rspec'

RSpec.configure do |config|
  config.infer_base_class_for_anonymous_controllers = false
  config.order = 'random'

  # factory bot shortcuts
  config.include FactoryBot::Syntax::Methods
  # Features helpers
  config.include Capybara::ActiveAdminHelpers, type: :feature

  config.before(:suite) do
    # Ensure database is empty before running specs
    DatabaseCleaner.clean_with :truncation
  end

  config.before(:each) do
    # Switch to truncation if example uses transactions
    DatabaseCleaner.strategy = Capybara.current_driver == :rack_test ? :transaction : :truncation
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.before(:each, type: :feature) do
    Capybara.current_driver = :selenium_chrome_headless
  end
end
