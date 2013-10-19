require_dependency "gringotts/application_controller"

module Gringotts
  class SettingsController < ApplicationController
    
    def index
      # if this is the first time the user has been to this settings page, create them
      # otherwise, look them up from last time they visited
      # this is lazy-creation of Gringotts users, so we don't have to tie in with normal user creation
      @user = Gringotts::User.find_or_create_by(user_id: current_user.id)
    end
    
    def update
    end
    
  end
end
