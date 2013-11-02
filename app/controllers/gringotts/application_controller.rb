class Gringotts::ApplicationController < ApplicationController
  # our verification pages should not require verification! can anyone say infinite redirect?
  skip_before_filter :gringotts_protego!
  
  before_filter :load_gringotts
  before_filter :ensure_not_locked

private
  
  def load_gringotts
    @gringotts = Gringotts::Vault.for_owner(gringotts_owner)
  end
  
  def ensure_not_locked
    redirect_to gringotts_engine.locked_path if @gringotts.locked?
  end
  
end
