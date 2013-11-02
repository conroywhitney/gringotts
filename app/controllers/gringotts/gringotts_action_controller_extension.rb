module Gringotts
  module GringottsActionControllerExtension
    
    # big thanks to StackOverflow user [cowboycoded]
    # http://stackoverflow.com/questions/3468858/rails-3-0-engine-execute-code-in-actioncontroller
    
    def self.included(base)
      # make our main rails app include our special GringottsHelper
      base.send(:include, GringottsHelper)
      
      # add a before_filter to ensure that users are being verified
      base.before_filter :gringotts_protego!
    end
    
  end
end