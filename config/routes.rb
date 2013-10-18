Gringotts::Engine.routes.draw do
  root :to => "settings#index"
  get "settings", :to => "settings#index", :as => :settings_url
end
