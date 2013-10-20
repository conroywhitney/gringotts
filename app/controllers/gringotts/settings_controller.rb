require_dependency "gringotts/application_controller"

module Gringotts
  class SettingsController < ApplicationController
    
    before_filter :load_gringotts_user
    
    def index  
    end
    
    def update
      @user.assign_attributes(user_params)
      
      if @user.save
        redirect_to root_url
      else
        render :index
      end
    end
    
private
    
    def load_gringotts_user
      # this is lazy-creation of Gringotts users, so we don't have to tie in with normal user creation
      @user = Gringotts::User.find_or_initialize_by(user_id: current_user.id)
    end
    
    def user_params
      params.require(:user).permit(:active, :phone_number)
    end
    
  end
end
