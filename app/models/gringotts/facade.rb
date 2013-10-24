module Gringotts
  class Facade
    
    def self.find(user = nil)
      return Gringotts::Facade.new(user)
    end
    
    def initialize(user = nil)
      raise "User is required" if user.nil?
      @user = user
    end
    
    def user_id
      return @user.id
    end

    def email
      return @user.email
    end
    
    def settings
      return Gringotts::Settings.find_by(user_id: @user.id)
    end
    
    def attempts
      return Gringotts::Attempt.find_by(user_id: @user.id)
    end

    def opted_in?
      return self.settings.present?
    end
    
  end
end