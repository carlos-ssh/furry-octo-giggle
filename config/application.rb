require_relative "boot"

require "rails/all"
require "csv"


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FurryOctoGiggle
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    config.i18n.default_locale = 'es'

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.assets.debug = false
    config.assets.compile = true
    config.assets.precompile += %w( *.js *.css )
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins 'https://rentaspostal.vercel.app/'
        resource(
          'https://rentaspostal.vercel.app/',
          headers: :any,
          methods: [:get, :patch, :put, :delete, :post, :options, :head]
          )
      end
    end
  end
end
