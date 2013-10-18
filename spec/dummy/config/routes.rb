Rails.application.routes.draw do

  # From "Devise with RSpec and Cucumber" Rails Tutorial
  # http://railsapps.github.io/tutorial-rails-devise-rspec-cucumber.html
#  authenticated :user do
#    root :to => 'home#index'
#  end
  root :to => "home#index"
  devise_for :users
  
  # Mount Gringotts engine wherever the hell you want to
  mount Gringotts::Engine => "/authentication", :as => :gringotts_engine
  
end
