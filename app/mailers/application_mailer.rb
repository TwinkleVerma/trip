class ApplicationMailer < ActionMailer::Base
  default from: 'twinkleverma19961@gmail.com'
  Rails.application.routes.default_url_options[:host] = 'fathomless-meadow-72894.herokuapp.com'
  # Rails.application.routes.default_url_options[:port] = '3000'
  layout 'mailer'
end
