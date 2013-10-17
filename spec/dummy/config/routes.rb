Rails.application.routes.draw do

  mount Gringotts::Engine => "/authentication"
  
end
