require_dependency "gringotts/application_controller"

module Gringotts
  class VerificationController < ApplicationController
    before_filter :require_gringotts
    
    def index
      @attempt = Gringotts::Attempt.new({user_id: current_user.id})
      #@code = @gringotts_user.current_code        
    end
    
    def attempt
      @attempt = Gringotts::Attempt.new(attempt_params)
      @attempt.user_id = @gringotts.user_id
      
      # try to save this attempt, though if it didn't validate, it won't save
      @attempt.save
      
      render :index
    end
    
private
    
    def require_gringotts
      @gringotts = Gringotts::Facade.find(current_user)
      
      redirect_to gringotts_engine.settings_path unless @gringotts.opted_in?
    end
    
    def attempt_params
      params.require(:attempt).permit(:code_received)
    end
    
  end
end
