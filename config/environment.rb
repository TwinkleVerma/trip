# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!
Rails.application.config.action_mailer.default_url_options = { :host => 'quiet-cliffs-56953.herokuapp.com'}
