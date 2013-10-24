class Gringotts::ApplicationController < ApplicationController
  before_filter :load_gringotts
  
private
  
  def load_gringotts
    @gringotts = Gringotts::Vault.where(user_id: current_user.id).first_or_create
  end
  
end
