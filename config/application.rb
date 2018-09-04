require_relative 'boot'

require 'rails/all'
require 'pdfkit'
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Trip
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.middleware.use PDFKit::Middleware, :print_media_type => true
    config.active_job.queue_adapter = :sidekiq
    config.assets.initialize_on_precompile = false

    config.serve_static_assets = true
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
