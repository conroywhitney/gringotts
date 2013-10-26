class Gringotts::ApplicationController < ApplicationController
  before_filter :load_gringotts
  before_filter :ensure_not_locked

private
  
  def load_gringotts
    @gringotts = Gringotts::Vault.where(user_id: current_user.id).first_or_create
  end
  
  def ensure_not_locked
    redirect_to gringotts_engine.locked_path if @gringotts.locked?
  end
  
end
