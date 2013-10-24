require_dependency "gringotts/application_controller"

module Gringotts
  class VerificationController < ApplicationController
    before_filter :require_gringotts_user
    
    def index
      @attempt = Gringotts::Attempt.new({user_id: current_user.id})
      #@code = @gringotts_user.current_code        
    end
    
    def attempt
    end
    
private
    
    def require_gringotts_user
      @gringotts_user = Gringotts::User.find(current_user)
      
      redirect_to gringotts_engine.settings_path unless @gringotts_user.opted_in?
    end
    
  end
end
