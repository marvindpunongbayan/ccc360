$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "Ccc360/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ccc360"
  s.version     = Ccc360::VERSION
  s.authors     = [%q{Josh Starcher}, %q{Weston Platter}]
  s.email       = [%q{josh.starcher@email.com}, %q{westonplatter@gmail.com}]
  s.homepage    = %q{http://www.somewhere.com}
  s.summary     = %q{ccc360 short}
  s.description = %q{ccc360 long}
  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- spec/*`.split("\n")

  s.add_development_dependency "rails", "~> 3.2.3"
  s.add_development_dependency "mysql2"
  s.add_development_dependency "acts_as_list"
  s.add_development_dependency "factory_girl"
  s.add_development_dependency "validate_email"
  s.add_development_dependency "airbrake"
  s.add_development_dependency "acts_as_state_machine"
  s.add_development_dependency "paperclip"
  s.add_development_dependency "dalli"
  s.add_development_dependency "liquid"
  s.add_development_dependency "aws-s3"
  s.add_development_dependency "rack-contrib"
  s.add_development_dependency 'jquery-rails'
  s.add_development_dependency "capybara"
	s.add_development_dependency "capistrano"
	s.add_development_dependency "newrelic_rpm"
	s.add_development_dependency "rubycas-client"
  
end
