require_dependency "gringotts/application_controller"

module Gringotts
  class SettingsController < ApplicationController
    before_filter :load_gringotts_settings
       
    def index  
    end
    
    def update
      @settings.assign_attributes(settings_params)
      
      if @settings.save
        flash[:notice] = "Successfully added phone number"
        redirect_to verification_url
      else
        render :index
      end
    end
    
private
    
    def load_gringotts_settings
      # this is lazy-creation of Gringotts settings, so we don't have to tie in with user creation in regular app
      @settings = @gringotts.settings || Gringotts::Settings.new({vault_id: @gringotts.id})
    end
    
    def settings_params
      params.require(:settings).permit(:active, :phone_number)
    end
    
  end
end
