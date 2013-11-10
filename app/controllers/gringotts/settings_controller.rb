require_dependency "gringotts/application_controller"

module Gringotts
  class SettingsController < ApplicationController
    before_filter :load_gringotts_settings
    
    def index
      if @gringotts.confirmed? && @gringotts.verified?(session)
        redirect_to gringotts_engine.success_path
      elsif @gringotts.phone_number.present?
        redirect_to gringotts_engine.verify_path
      else
        redirect_to gringotts_engine.setup_path
      end
      return true
    end
    
    def setup
    end
    
    def prompt
      # see if we have a url saved (we should, but for safety, if missing, just redirect to root)
      @next_url = gringotts_next_url || main_app.root_url
      
      if @gringotts.show_prompt?
        # going to show prompt
        # need to remember that have shown, so not show twice
        @gringotts.prompt_shown!
      else
        # should not see it twice
        redirect_to @next_url
      end
    end
    
    def update
      @settings.assign_attributes(settings_params)
      
      if @settings.save
        redirect_to verification_url
      else
        render :setup
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
