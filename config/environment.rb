# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!
if Rails.env.development?
  Rails.application.config.action_mailer.default_url_options = { :host => 'localhost', port: 3000 }
else
  Rails.application.config.action_mailer.default_url_options = { :host => 'quiet-cliffs-56953.herokuapp.com'}
end
