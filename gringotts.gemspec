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

  s.add_dependency "rails", "~> 3.2.14"

  s.add_development_dependency "sqlite3"
end
