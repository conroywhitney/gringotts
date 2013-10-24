module Gringotts
  class User
    
    def self.find(user = nil)
      return Gringotts::User.new(user)
    end
    
    def initialize(user = nil)
      raise "User is required" if user.nil?
      @user = user
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
    
private
    
    def method_missing(method, *args, &block)
      if @user.respond_to? method
        @user.send(method, *args, &block)
      else
        super
      end
    end
    
  end
end