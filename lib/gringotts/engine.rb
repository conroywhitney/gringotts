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
    
    # load config file
    initializer :load_config_yml do |app|
      config_path = app.root.join('config', "gringotts.yml")
      if File.exists?(config_path)
        config = YAML.load_file(config_path)
        # load the informationz....
      else
        raise Exception.new("You must create the file #{config_path}. Please see documentation for more details: https://github.com/conroywhitney/gringotts")
      end
    end
    
  end
end
