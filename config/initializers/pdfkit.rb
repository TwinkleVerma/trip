PDFKit.configure do |config|
  config.wkhtmltopdf = '/home/ubox81/.rvm/gems/ruby-2.4.1/bin/wkhtmltopdf'
  config.default_options = {
    page_size: 'Legal',
    print_media_type: true
  }
  config.root_url = "http://localhost:3000/"
  config.verbose = false
end
