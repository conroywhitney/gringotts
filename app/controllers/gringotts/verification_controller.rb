require_dependency "gringotts/application_controller"

module Gringotts
  class VerificationController < ApplicationController
    before_filter :require_gringotts
    before_filter :ensure_not_locked,  :except => [:locked]
    before_filter :initialize_attempt, :except => [:success]
    
    def index
      @code = @gringotts.new_code
      @errors = []
    end
    
    def attempt
      @attempt.assign_attributes(attempt_params)
      
      @attempt.validate(@gringotts.recent_code)
      
      # Need to .dup because .save is going to erase all errors =(
      @errors = @attempt.errors.dup
      
      # after all that, save a record of this attempt
      @attempt.save
      
      if @attempt.successful?
        redirect_to gringotts_engine.success_path
      elsif @gringotts.reload.locked?
        redirect_to gringotts_engine.locked_path
      else
        @code = @gringotts.recent_code
        render :index
      end
    end
    
    def success
    end
    
    def locked
    end
    
private
    
    def require_gringotts
      redirect_to gringotts_engine.settings_path unless @gringotts.opted_in?
    end
    
    def ensure_not_locked
      redirect_to gringotts_engine.locked_path if @gringotts.locked?
    end
    
    def initialize_attempt
      @attempt ||= Gringotts::Attempt.new({vault_id: @gringotts.id})
    end
    
    def attempt_params
      params.require(:attempt).permit(:code_received)
    end
    
  end
end
