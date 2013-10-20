require_dependency "gringotts/application_controller"

module Gringotts
  class SettingsController < ApplicationController
    
    before_filter :load_gringotts_settings
    
    def index  
    end
    
    def update
      @settings.assign_attributes(settings_params)
      
      if @settings.save
        redirect_to root_url
      else
        render :index
      end
    end
    
private
    
    def load_gringotts_settings
      # this is lazy-creation of Gringotts settings, so we don't have to tie in with user creation in regular app
      @settings = Gringotts::Settings.find_or_initialize_by(user_id: current_user.id)
    end
    
    def settings_params
      params.require(:settings).permit(:active, :phone_number)
    end
    
  end
end
