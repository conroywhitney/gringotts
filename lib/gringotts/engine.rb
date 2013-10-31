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
    # thanks to: http://gregmoreno.wordpress.com/2012/05/29/create-your-own-rails-3-engine/
    initializer :load_config_yml do |app|
      config_path = app.root.join('config', "gringotts.yml")
      if File.exists?(config_path)
        if (raw_yaml = File.read(config_path))
          Gringotts::Config.load(raw_yaml)
        else
          raise "Could not load config file [#{config_path}]. File is probably either not valid YAML or is empty."
        end
      else
        raise Exception.new("You must create the file [#{config_path}]. Please see documentation for more details: https://github.com/conroywhitney/gringotts")
      end
    end
    
  end
end
