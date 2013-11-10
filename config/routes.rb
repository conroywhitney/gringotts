Gringotts::Engine.routes.draw do

  # index will decide where user should be redirected to
  root :to => "settings#index"

  get    "prompt",          :to => "settings#prompt",  :as => :prompt
  get    "setup",           :to => "settings#setup",   :as => :setup
  post   "settings/update", :to => "settings#update",  :as => :update_settings
  # disable should be DESTROY, but had issue with data-method so using POST for now
  post   "disable",         :to => "settings#disable", :as => :disable
  
  get  "verify",  :to => "verification#index",   :as => :verification
  post "attempt", :to => "verification#attempt", :as => :attempt
  get  "success", :to => "verification#success", :as => :success
  get  "locked",  :to => "verification#locked",  :as => :locked
  
end
