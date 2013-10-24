Gringotts::Engine.routes.draw do

  root :to => "settings#index"
  
  get "settings", :to => "settings#index", :as => :settings
  post "settings/update", :to => "settings#update", :as => :update_settings
  
  get "verify", :to => "verification#index", :as => :verification
  
  get "attempt", :to => "verification#attempt", :as => :attempt
  
end
