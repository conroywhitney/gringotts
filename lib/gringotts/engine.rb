module Gringotts
  class Engine < ::Rails::Engine
    isolate_namespace Gringotts

    # load config/gringotts.yml file from main rails app's config path
    # give helpful warning messages if missing or invalid (e.g., after first installing gem)
    # thanks to: http://gregmoreno.wordpress.com/2012/05/29/create-your-own-rails-3-engine/
    # note: currently this is the cause of indetermanistic test behaviour
    # sometimes the config file is being loaded before test fixtures, othertimes not
    # working on figuring out why ...
    initializer :load_config_yml do |app|
      config_path = app.root.join('config', "gringotts.yml")

      unless File.exists?(config_path)
        raise "You must create the file [#{config_path}]. Please see documentation for more details: https://github.com/conroywhitney/gringotts"
      end
      
      unless (raw_yaml = File.read(config_path))
        raise "Could not load config file [#{config_path}]. File is probably either not valid YAML or is empty."
      end
      
      Gringotts::Config.load(raw_yaml)
    end
    
    # add engine's migrations into application's migration path
    # when we run rake db:migrate in main app, our engine's migrations will be run, too!
    # thanks to: http://pivotallabs.com/leave-your-migrations-in-your-rails-engines/
    initializer :append_migrations do |app|
      unless app.root.to_s.match root.to_s
        config.paths["db/migrate"].expanded.each do |expanded_path|
          app.config.paths["db/migrate"] << expanded_path
        end
      end
    end

    # hijack the main rails application controller
    # does things like: include a helper, and add a before_filter
    # thanks to: http://stackoverflow.com/questions/3468858/rails-3-0-engine-execute-code-in-actioncontroller
    initializer :hijack_main_app_controller do |app|  
      ActiveSupport.on_load(:action_controller) do  
         include GringottsActionControllerExtension  
      end
    end
    
    # Adding RSpec test configuration (don't create fixtures, use factory_girl, etc)
    # thanks to: http://viget.com/extend/rails-engine-testing-with-rspec-capybara-and-factorygirl    
    config.generators do |g|
      g.test_framework      :rspec,        :fixture => false,   :view_specs => false  
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
      g.assets false
      g.helper false
    end
    
  end
end
