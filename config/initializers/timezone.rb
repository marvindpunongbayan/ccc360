require 'rack/contrib'
Ccc360::Application.config.middleware.use Rack::Locale
Ccc360::Application.config.middleware.use Rack::TimeZone