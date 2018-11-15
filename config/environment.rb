# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

if Rails.env.development?
  Rails.application.config.twilio_configuration = {twilio_number: '+15085036936', auth_token: 'f70c11f86b24a0986dc5f7db2e449aef', account_sid: 'AC26fc510a58e871f155ff5326a1d60602'}
  Rails.application.config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
else
  Rails.application.config.action_mailer.default_url_options = { host: 'quiet-cliffs-56953.herokuapp.com'}
end

