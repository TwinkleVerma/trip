class ApplicationMailer < ActionMailer::Base
  default from: 'twinkleverma19961@gmail.com'
  Rails.application.routes.default_url_options[:host] = 'quiet-cliffs-56953.herokuapp.com'
  Rails.application.routes.default_url_options[:host] = 'localhost' if Rails.env.development? || Rails.env.development?
  Rails.application.routes.default_url_options[:port] = '3000' if Rails.env.development? || Rails.env.development?
  layout 'mailer'
end
