Gringotts::Engine.routes.draw do

  root :to => "settings#index"
  
  get  "settings",        :to => "settings#index",  :as => :settings
  post "settings/update", :to => "settings#update", :as => :update_settings
  get  "prompt",          :to => "settings#prompt", :as => :prompt
  
  get  "verify",  :to => "verification#index",   :as => :verification
  post "attempt", :to => "verification#attempt", :as => :attempt
  get  "success", :to => "verification#success", :as => :success
  get  "locked",  :to => "verification#locked",  :as => :locked
  
end
