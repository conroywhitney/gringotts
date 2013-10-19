require 'factory_girl_rails'

# Load FactoryGirl factories manually (not sure why not loading automatically)
Dir["#{Gringotts::Engine.root}/spec/factories/*.rb"].each { |f| require f }

# FactoryGirl Step Definitions via tutorial:
# http://collectiveidea.com/blog/archives/2010/09/09/practical-cucumber-factory-girl-steps/
# TODO: not sure why, but getting this error:
#      cannot load such file -- factory_girl_rails/step_definitions (LoadError) 
# But since I'm not using this feature right now, I'm not going to worry about it
# I'm just leaving this here as a reference for future investigation
#require "factory_girl/step_definitions"