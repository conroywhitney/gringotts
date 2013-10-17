module Gringotts
  class Engine < ::Rails::Engine
    isolate_namespace Gringotts
    
    initializer :append_migrations do |app|
      unless app.root.to_s.match root.to_s
        config.paths["db/migrate"].expanded.each do |expanded_path|
          app.config.paths["db/migrate"] << expanded_path
        end
      end
    end

    # Adding spec per article
    # http://viget.com/extend/rails-engine-testing-with-rspec-capybara-and-factorygirl    
    config.generators do |g|
      g.test_framework      :rspec,        :fixture => false,   :view_specs => false
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
      g.assets false
      g.helper false
    end
    
  end
end
