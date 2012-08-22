source 'http://rubygems.org'

# infrastructure
gem 'rails', '~>3.2.6'
gem 'mysql2'
gem 'dalli'
gem 'debugger'
gem 'rack-contrib' 
gem 'newrelic_rpm'
gem 'capistrano'
gem 'airbrake'

# authentication
# gem 'devise'
# gem 'omniauth-cas'

# website functionality
gem 'jquery-rails'
gem 'acts_as_list'
gem 'aasm'
gem 'state_machine'
gem 'validate_email'
gem 'paperclip'
gem 'liquid'
gem 'aws-s3'

# cru gems
gem 'questionnaire_engine', :git => 'git://github.com/westonplatter/questionnaire_engine.git', :branch => 'engine'
# gem 'common_engine' # switching over to gem version of common_engine

group :assets do
	gem 'sass-rails'
	gem 'coffee-rails'
	gem 'uglifier'
end

group :test, :development do
	gem 'factory_girl'
	gem 'rspec-rails'
		gem 'guard-rspec'
		gem 'launchy'
		gem 'capybara'
end

gem 'rails-footnotes', '>= 3.7.5.rc4', :group => :development
