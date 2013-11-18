class Gringotts::ApplicationController < ApplicationController
  
  before_filter :load_gringotts
  before_filter :ensure_not_locked

private
  
  def load_gringotts
    @gringotts = Gringotts::Vault.for_owner(gringotts_owner)
  end
  
  def ensure_not_locked
    redirect_to gringotts_engine.locked_path if @gringotts.locked?
  end
  
  def accepts_strong_params?
    params.respond_to?(:require) && params.respond_to?(:permit)
  end
  
end
