require_dependency "gringotts/application_controller"

module Gringotts
  class VerificationController < ApplicationController
    
    # our verification pages should not require verification! can anyone say infinite redirect?
    skip_before_filter :gringotts_protego!, :only => [:index, :attempt, :locked] 
    
    before_filter :require_gringotts
    before_filter :ensure_not_locked,  :except => [:locked]
    before_filter :initialize_attempt, :except => [:success]
    
    def index
      @gringotts.deliver_new_code!
      @code = @gringotts.recent_code.value
      
      if @gringotts.opted_in?
        return render :verify
      else
        return render :confirm
      end
    end
    
    def attempt
      if accepts_strong_params?
        @attempt.assign_attributes(attempt_params)
      else
        @attempt.update_attributes(code_received: params[:attempt][:code_received])
      end
      
      @attempt.validate(@gringotts.recent_code)
      
      # Need to .dup because .save is going to erase all errors =(
      @errors = @attempt.errors.dup
      
      # after all that, save a record of this attempt
      @attempt.save
      
      if @attempt.successful?
        # remember that they have been verified
        @gringotts.verify!(session)
        
        # if account was locked before, unlock!
        @gringotts.unlock! if @gringotts.locked?
        
        # this might be the first time they are validating their phone number
        # therefore confirm the validity only if unconfirmed. ya dig?
        if @gringotts.confirmed?
          # normal verification path
          
          # TODO: in future, redirect them to wherever they were going before...
          redirect_to gringotts_engine.success_path
        else
          # first-time verification path
          
          # mark that their phone number has been confirmed so that 2FA can be used
          @gringotts.confirm!
          
          # kick them to a success page letting them know that 2FA is set up
          redirect_to gringotts_engine.success_path
        end
      elsif @gringotts.should_lock?
        @gringotts.lock!
        redirect_to gringotts_engine.locked_path
      else
        flash[:gringotts_error] = "Code was incorrect. A new code has been sent to your phone. Please try again."
        return redirect_to gringotts_engine.verification_path
      end
    end
    
    def success
    end
    
    def locked
    end
    
private
    
    def require_gringotts
      redirect_to gringotts_engine.setup_path unless @gringotts.signed_up?
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
