# Adding spec support per article
# http://viget.com/extend/rails-engine-testing-with-rspec-capybara-and-factorygirl

ENV['RAILS_ENV'] ||= 'test'

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'factory_girl_rails'

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Load FactoryGirl factories manually
# For some reason, specifying :dir => in engine.rb wasn't working  =(
Dir["#{File.dirname(__FILE__)}/factories/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
end
