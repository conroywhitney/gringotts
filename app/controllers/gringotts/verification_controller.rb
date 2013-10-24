require_dependency "gringotts/application_controller"

module Gringotts
  class VerificationController < ApplicationController
    before_filter :require_gringotts
    before_filter :initialize_attempt
    
    def index
      #@code = @gringotts_user.current_code        
    end
    
    def attempt
      @attempt.assign_attributes(attempt_params)
      
      # try to save this attempt, though if it didn't validate, it won't save
      @attempt.save
      
      render :index
    end
    
private
    
    def require_gringotts
      redirect_to gringotts_engine.settings_path unless @gringotts.opted_in?
    end
    
    def initialize_attempt
      @attempt = Gringotts::Attempt.new({vault_id: @gringotts.id})
    end
    
    def attempt_params
      params.require(:attempt).permit(:code_received)
    end
    
  end
end
