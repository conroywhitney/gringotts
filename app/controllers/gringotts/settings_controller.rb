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
      @user = User.new(user_params)
      
      if @user.valid?
        redirect_to challenge_url
      else
        render :index
      end
    end
    
private
    
    def user_params
      params.require(:user).permit(:active, :phone_number)
    end
    
  end
end
