$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "gringotts/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "gringotts"
  s.version     = Gringotts::VERSION
  s.authors     = ["Conroy Whitney"]
  s.email       = ["conroy.whitney@gmail.com"]
  s.homepage    = "https://github.com/conroywhitney/gringotts"
  s.summary     = "2FA Engine for Rails"
  s.description = "Drop in 2-Factor Authorization for your Rails app. You just need a Twilio account and you're set."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.0.0"

  s.add_development_dependency "sqlite3"
  
  # Adding spec per
  # http://viget.com/extend/rails-engine-testing-with-rspec-capybara-and-factorygirl
  s.test_files = Dir["spec/**/*"]
  s.add_development_dependency 'rspec-rails', "~> 2.14.0"
  s.add_development_dependency "capybara", "~> 2.1.0"
  s.add_development_dependency "factory_girl_rails", "~> 4.2.1"
end
