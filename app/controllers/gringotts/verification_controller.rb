require_dependency "gringotts/application_controller"

module Gringotts
  class VerificationController < ApplicationController
    before_filter :require_gringotts
    before_filter :initialize_attempt
    
    def index
      @code = @gringotts.new_code
      @errors = []
    end
    
    def attempt
      @attempt.assign_attributes(attempt_params)
      
      if @attempt.valid?
        # if it has everything necessary ActiveRecord-wise
        # see if it's actually matches what we we expect
        AttemptValidator.validate(@attempt)
      end
    
      # Need to .dup because .save is going to erase all errors =(
      @errors = @attempt.errors.dup
      
      # after all that, save a record of this attempt
      @attempt.save  
  
      render :index
    end
    
private
    
    def require_gringotts
      redirect_to gringotts_engine.settings_path unless @gringotts.opted_in?
    end
    
    def initialize_attempt
      @attempt ||= Gringotts::Attempt.new({vault_id: @gringotts.id})
    end
    
    def attempt_params
      params.require(:attempt).permit(:code_received)
    end
    
  end
end
