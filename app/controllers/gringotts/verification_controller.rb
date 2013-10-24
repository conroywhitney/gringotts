require_dependency "gringotts/application_controller"

module Gringotts
  class VerificationController < ApplicationController
    before_filter :gringotts_user
    
    def index
      #@code = @gringotts_user.current_code        
    end
    
private
    
    def gringotts_user
      @gringotts_user = Gringotts::User.find(current_user)
    end
    
  end
end
