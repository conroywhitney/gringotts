module Gringotts
  module ApplicationHelper
    
    # Can search for named routes directly in the main app, omitting
    # the "main_app." prefix
    # Thanks to: https://github.com/KatanaCode/blogit/blob/4a68b1626eb9baddc6b644294239b046a60fffac/app/helpers/blogit/application_helper.rb
    def method_missing method, *args, &block
      if main_app_url_helper?(method)
        main_app.send(method, *args)
      else
        super
      end
    end
    
    def respond_to?(method)
      main_app_url_helper?(method) or super
    end

    private

    def main_app_url_helper?(method)
      (method.to_s.end_with?('_path') or method.to_s.end_with?('_url')) and
       main_app.respond_to?(method)
    end
    
  end
end
