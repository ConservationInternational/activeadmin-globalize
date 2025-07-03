require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
require "activeadmin-globalize"

module Dummy
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configure available locales for testing
    config.i18n.available_locales = [:en, :it, :hu, :de]
    config.i18n.default_locale = :en

    # Add parent gem's assets to the asset path
    config.assets.paths << Rails.root.join('..', '..', 'app', 'assets', 'javascripts')
    config.assets.paths << Rails.root.join('..', '..', 'app', 'assets', 'stylesheets')
    config.assets.paths << Rails.root.join('..', '..', 'app', 'assets', 'images')

    # Add the gem's asset directories to the asset pipeline paths
    config.assets.paths << Rails.root.join('..', 'app', 'assets', 'javascripts')
    config.assets.paths << Rails.root.join('..', 'app', 'assets', 'stylesheets')
    config.assets.paths << Rails.root.join('..', 'app', 'assets', 'images')

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
