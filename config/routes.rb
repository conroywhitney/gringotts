Gringotts::Engine.routes.draw do

  root :to => "settings#index"
  
  get "settings", :to => "settings#index", :as => :settings_url
  post "settings/update", :to => "settings#update", :as => :update_settings_url
  
  get "verify", :to => "verification#index", :as => :verification_url
  
end
