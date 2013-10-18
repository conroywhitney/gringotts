begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'rdoc/task'

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Gringotts'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

APP_RAKEFILE = File.expand_path("../spec/dummy/Rakefile", __FILE__)
load 'rails/tasks/engine.rake'

# Add spec support per article
# http://viget.com/extend/rails-engine-testing-with-rspec-capybara-and-factorygirl
Dir[File.join(File.dirname(__FILE__), 'tasks/**/*.rake')].each {|f| load f }

require 'rspec/core'
require 'rspec/core/rake_task'

# Test that our factories are valid before we try to run any of our spec tests
# http://robots.thoughtbot.com/post/30994874643/testing-your-factories-first
if defined?(RSpec)
  desc 'Run factory specs.'
  RSpec::Core::RakeTask.new(:factory_specs) do |t|
    t.pattern = './spec/factories_spec.rb'
  end
end

#desc "Test that our factories are valid before we try running any spec tests"
task :spec, :factory_specs

#desc "Run all specs in spec directory (excluding plugin specs)"
RSpec::Core::RakeTask.new(:spec => 'app:db:test:prepare')

# Adding cucumber support per tutorial:
# http://blog.crowdint.com/2012/03/20/mountable-rails-engines.html
task :cucumber => 'app:cucumber'

task :default => [:spec, :cucumber]

Bundler::GemHelper.install_tasks