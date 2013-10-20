== Gringotts 2FA (2-Factor Authentication) Engine for Rails

**Note: This project is still pre-release (version < 1.0). Definitely *not* ready for production use. Obviously. I mean, just look at it.**

**Other Note: This is currently being developed against Rails 4 which requires Ruby 1.9.3+. Support for Rails 3.2.x will come later. Let me know if you would like to help.**

![Build Status](https://travis-ci.org/conroywhitney/gringotts.png?branch=master)

Drop-in two-factor authentication for your Ruby on Rails Project. Eazy peazy.

Creates a set of models, views, and controllers to handle user opt-in, phone number confirmation, and verification after login.

== Installation

Add the Gringotts gem to your bundler Gemfile

    gem "gringotts"
    
Mount the Gringotts engine in your `config/routes.rb` file

    mount Gringotts::Engine => "/authentication", :as => :gringotts_engine

Add Gringotts tables to your database

    bundle exec rake db:migrate
    
Configure your `gringotts.yml` file

    twilio:
      account_sid: *********************
      auth_token:  *********************
      
Run the `rspec` and `cucumber` tests to ensure correct installation

    rake
    
