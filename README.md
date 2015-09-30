Gringotts: 2FA Phone Verification Engine for Rails
------

**Note:** This project is still pre-release (version < 1.0). Definitely *not* ready for production use and *will* change significantly in the near future. However, please *do* test it out on an experimental branch of your application and give your feedback!

[![Gem Version](https://badge.fury.io/rb/gringotts.svg)](http://badge.fury.io/rb/gringotts)
[![Build Status](https://travis-ci.org/conroywhitney/gringotts.svg?branch=master)](https://travis-ci.org/conroywhitney/gringotts)
[![Dependency Status](https://gemnasium.com/conroywhitney/gringotts.svg)](https://gemnasium.com/conroywhitney/gringotts)
[![Code Climate](https://codeclimate.com/github/conroywhitney/gringotts.png)](https://codeclimate.com/github/conroywhitney/gringotts)


What is Gringotts?
--------

Gringotts is a plug-n-play [two-factor authentication (2FA)](http://en.wikipedia.org/wiki/Multi-factor_authentication) phone verification [rails engine](http://guides.rubyonrails.org/engines.html). It sends a [one-time password](http://en.wikipedia.org/wiki/One-time_password) to a user over SMS which is used to verify that the user is are who they say they are.


**For you**, it works like this:

 1. Sign up for a [Twilio](https://www.twilio.com/) account and add some credits

 2. Install and configure the Gringotts gem with your Twilio credentials

 3. Sit back and feel proud knowing that you made your users' accounts more secure


**For your users**, it works like this:

 1. They choose to opt-in to phone verification to make their account more secure

 2. They enter their phone number and confirm the code sent via text message to their phone

 3. Every time they log in and are asked to enter a new code, they are reminded that their account is protected, and that only they are able to access their personal information


Give It a Test Drive
------------

Sound too good to be true? Don't take my word for it, check it out for yourself:

[http://gringotts.herokuapp.com](http://gringotts.herokuapp.com)


See the entire changeset that took that demo app from being a regular rails app to having 2FA:

[https://github.com/conroywhitney/gringotts-client/compare/master...installed](https://github.com/conroywhitney/gringotts-client/compare/master...installed)


Installation
-------

**1. Add the Gringotts gem** to your bundler Gemfile

    gem "gringotts"
    

**2. Mount the Gringotts engine** in your `config/routes.rb` file for whatever virtual path you want to use (e.g., `/authentication`, `/phone`, `/omg-so-secure`, whatever you want).

*Note: please do not change the `:as => :gringotts_engine`. That part is important.*

    mount Gringotts::Engine => "/authentication", :as => :gringotts_engine


**3. Add Gringotts' tables** to your database

*Note: this only creates new tables; it does not modify any of your existing tables. y4y!*

    bundle exec rake db:migrate
    

**4. Configure Gringotts** with your `gringotts.yml` file, adding your Twilio account credentials, and optionally altering other default behaviour

*Note: `from_number` is what Twilio gives you; `phone_number_override` is for testing in development.*

    twilio_settings: &twilio_settings
      from_number: "1-###-###-####"
      account_sid: "**********************************"
      auth_token:  "********************************"

    delivery_settings: &delivery_settings
      enabled: true
      phone_number_override: "1-###-###-####"
  
    defaults: &defaults
      enabled: true
      delivery:
        <<: *delivery_settings
      twilio:
        <<: *twilio_settings
      ignore_paths:
        - /users/sign_out
        - /users/sign_in

    development:
      <<: *defaults
      delivery:
        <<: *delivery_settings
        enabled: false

    test:
      <<: *defaults
    
    production:
      <<: *defaults
      enabled: false


**5. Add Gringotts stylesheets** to `app/assets/javascripts/application.js`

*Note: recommened before your `*= require_tree .` so you can override certain styles if you want*

    *= require_self
    *= require gringotts
    *= require_tree .


**6. Fire up your application**, log in, and you should see a prompt to turn on mobile phone authentication.


Is Gringotts Secure?
-------------

As a gem whose main purpose is to provide additional security to your rails application, it is obviously important to address in what areas this gem is secure and how it can be improved. This will be an ongoing area of focus. By all means, don't take my word for this. Check out the code yourself. Join the conversation if you see an area for improvement. Suggest a "what if?" test case. Point out how something could be abused. Be paranoid! There are no dumb scenarios.

##Current Security Measures

 * **Codes Expire:** If a user does not enter their code within a certain amount of time, that code becomes useless. This ensures that unused codes are not just sitting around waiting to be exploited.

 * **One-Time Use Codes:** A code cannot be entered more than once. This prevents [replay attacks](http://en.wikipedia.org/wiki/Replay_attack).

 * **Lock Out:** A user can only attempt to enter a maximum number of codes within a given period of time. This protects against [brute-force attacks]( http://en.wikipedia.org/wiki/Brute-force_attack)
 
 * **Forward Secrecy:** Unlike other OTP systems (like Google Authenticator) that rely on a shared secret, even if one Gringotts code is compromised, future verifications will still be secure.

##Roadmap of Improvements

 * **One-Way Encrypted Codes:** Store the codes like you store a password. After the initial sending of the code, there is no need to know the code’s value – only whether a user entry matches.

 * **Two-Way Encrypted Phone Numbers:** Phone numbers need to be retrieved and used for sending new codes in the future; however, users’ phone numbers do *not* need to be stored in plain-text. 


Why Bother with 2-Factor Authentication?
-------

Having 2-factor authentication adds one more layer of security to your users’ accounts. As they say, it’s “something you know, and something you have”. The combination of those two ensures that when your users log in, you know that it’s them, not somebody else who has their password. But, again, don’t take my word for it. Check out what these other talking heads have to say:
<br>

> No matter how complex, no matter how unique, your passwords can no longer protect you... [H]ackers [are regularly] breaking into computer systems and releasing lists of usernames and passwords on the open web.
<br>
 
 \- Matt Honan, Wired.com, *[Kill the Password: Why a String of Characters Can't Protect Us Anymore](http://www.wired.com/gadgetlab/2012/11/ff-mat-honan-password-hacker/all/)*


> 2-step verification drastically reduces the chances of having the personal information in your Google account stolen by someone else. Why? Because hackers would have to not only get your password and your username, they'd have to get a hold of your phone.
<br>

 \- *[Google 2-Step Verification Home](https://support.google.com/a/answer/175197)*


> If [two-step verification], were used on all limited-access Web sites, the passwords wouldn't have to be long and complex. But many Web users have easy-to-guess passwords in just one-step verification, which is highly imprudent.
<br>
 
 \- Randall Stross, New York Times, *[Doing the Two-Step, Beyond the A.T.M.](http://www.nytimes.com/2012/10/14/technology/two-step-verification-is-inconvenient-but-more-secure.html)*


> With [single-factor authentication] becoming increasingly unreliable as a security measure, two-factor authentication is rapidly gaining importance for logging into online accounts.
<br>
 
 \- Tina Sieber, MakeUseOf.com, *[What Is Two-Factor Authentication, And Why You Should Use It](http://www.makeuseof.com/tag/what-is-two-factor-authentication-and-why-you-should-use-it/)*


The Gringotts Philosophy
-------
 * Gringotts is about increased **security consciousness**. It is the beginning of a conversation between users and makers about how we can work together to make the internet a safer and more private place for everyone.

 * Gringotts is about **empowering users** to take back control over their online identities. It is about giving developers the tools necessary to assist their users.

 * Gringotts is about **decentralization** in an age of aggregation. Single points of failure – even when distributed -- have proven to be a failed experiment. 

 * Gringotts is about **collaboration**. Moving forward, every action should be considered in the context of whether this promotes openness, or closed systems.


Contributing
------
 * **High Level:** Constructive criticism of this implementation of 2-Factor Authentication (OTP send through SMS)

 * **Flow:** Suggestions on improving the user-experience (opt-in, confirmation, verification, locked-out, opt-out)
 
 * **Issues:** Test this with your application and let me know how it goes! (Remember: create an experimental branch!)

 * **Improvements:** You know the drill: fork, create topic branch, write test cases, make change, submit pull request.

 * **Encouragement:** Success stories or other *buenas ondas* validating that this project is worthwhile.


Special Thanks To
-----

* [@troyd](https://twitter.com/troyd) for conceptual feedback in the early stages and consistent encouragement to get my ass in gear.

* Abhishek for philosophical discussions about motivation and the lack there-of. "Don't think. Just do it."

* [jlukic](https://github.com/jlukic/) for inspiring me to with his kick.ass. [Semantic-UI](http://semantic-ui.com) project. Keep up the great work, dude.

* [Nitrous.io](https://www.nitrous.io/join/012YtP048go) for the awesome web-based IDE that allows me to work from internet cafes. (disclaimer: referral link)

* [Supertramp Hostel](http://www.supertramphostel.com/en) and Machu Picchu, Peru for 8 months of good times, food, accommodation, internet, and motivation to get the hell out of here and get on with my life. Thanks, I really needed this. =)

* All the other blogs, tutorials, websites, and gems that have influenced and acted as a model for this gem. Open Source Software FTW!


License
-------
Copyright 2013 Conroy Whitney

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


Disclaimer
-----
Gringotts 2-Factor Authentication is not associated with Warner Bros. Entertainment Inc., J.K. Rowling, or any of the "Harry Potter" books or films. HARRY POTTER is a registered trade-mark of Warner Bros. Entertainment Inc.

*Note: I never thought I would ever have a reason to need to use a disclaimer like this... fun!*
