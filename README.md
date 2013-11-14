Gringotts 2FA (2-Factor Authentication) Engine for Rails
------

**Note:** This project is still very much pre-release (version < 1.0). Definitely *not* ready for production use. However, please *do* test it out on an experimental branch of your application and create github issues (with supporting documentation) related to what you find.

**Additional Note:** This is currently being developed against Rails 4 which requires Ruby 1.9.3+. Support for Rails 3.2.x is definitely planned but will not become a priority until after an initial beta version for Rails 4 is ready.

<img src="http://images2.wikia.nocookie.net/__cb20120724185750/harrypotter/images/2/25/Gringotts_New_Logo.jpg" width="50"> [![Build Status](https://travis-ci.org/conroywhitney/gringotts.png?branch=master)](https://travis-ci.org/conroywhitney/gringotts)  [![Code Climate](https://codeclimate.com/github/conroywhitney/gringotts.png)](https://codeclimate.com/github/conroywhitney/gringotts)


What is Gringotts?
--------

Gringotts is a [two-factor authentication (2FA)](http://en.wikipedia.org/wiki/Multi-factor_authentication) [Rails Engine](http://guides.rubyonrails.org/engines.html). It sends a [one-time password](http://en.wikipedia.org/wiki/One-time_password) to users over SMS which verifies that they are who they say they are. All you need is a [Twilio](https://www.twilio.com/) account to send the SMS, and you are set.

Gringotts allows your users to optionally add 2FA to their existing accounts. Their mobile phone number is collected, validated, and stored encrypted in your database. When a user logs in from an unknown device (like an internet cafe), or if their last 2FA confirmation was more than 30 days ago, they are sent a 4-digit number through a text message that is valid for only a short period of time, and only from the device for which it was sent. After the user enters the correct number, they can use your site like normal. If they enter a wrong number too many times, they are locked out for a short time period. If they do not have access to, or have lost their mobile phone, there is a way for them to prove their identity through another means. (That last sentence is intentionally vague.)

As a Rails Engine, Gringotts creates a set of models, views, and controllers to handle all of the user messaging, information collection, phone number confirmation, and verification. It is essentially an app within your app, bundling up and providing all the relevant functionality for handling two-factor authentication. If you want to change any of the interface or behaviour, you can optionally bring Gringott's content down into your application and overwrite it. 


Installation
-------

Add the Gringotts gem to your bundler Gemfile

    gem "gringotts"
    
Mount the Gringotts engine in your `config/routes.rb` file for whatever virtual path you want to use (e.g., `/authentication`, `/security`, `/mobile-auth`, whatever you want). Note: please do not change the `:as => :gringotts_engine`

    mount Gringotts::Engine => "/authentication", :as => :gringotts_engine

Add Gringotts' tables to your database (note: this only creates *new* tables; it does *not* modify any of your existing tables)

    bundle exec rake db:migrate
    
Configure Gringotts with your `gringotts.yml` file, adding your Twilio account credentials, and optionally altering other default behaviour

    twilio:
      account_sid: *********************
      auth_token:  *********************

Add Gringotts stylesheets to `app/assets/javascripts/application.js` (recommened before your `*= require_tree .` so you can override certain styles if you want)

    *= require_self
    *= require gringotts
    *= require_tree .

And you should be all set. Fire up your application, log in, and you should see a prompt to turn on mobile phone authentication.

Why Do I Need Two-Factor Authentication?
-------

### Public WiFi and Keyloggers

When your users use your application over a public WiFi connection (like a Starbucks), or when they use an internet cafe, they are potentially exposing their account to malicious actors who can potentially discover their passwords and therefore access their account. By adding 2-Factor Authentication to your application, even if a user's password is compromised, the malicious actor will be unable to log in without access to the user's mobile phone. Problem solved.


### Database Leaks

It happens to the best: Dropbox, Twitter, Adobe, Sony; the list goes on and on. These days, it is best to assume that it is only a matter of time before your database is compromised. Once a malicious actor has access to your users' passwords and salts, it is only a matter of time before they are able to brute-force crack the passwords and thus gain access to your users' accounts. By adding 2-Factor Authentication that uses a random one-time-password (OTP), these cracked passwords are no longer enough to gain access -- they would either have to have access to your users' mobile phones, or your live database data, in order to gain entry.


### NSA Overreach

I don't know about you, but in my humble opinion, the Feds can go fuck themselves. In these days of [PRISM](http://en.wikipedia.org/wiki/PRISM_(surveillance_program) and [the NSA forcing companies to hand over encrypted passwords](http://www.npr.org/blogs/thetwo-way/2013/07/26/205709369/report-feds-have-asked-web-firms-for-users-passwords), adding one more layer of "fuck you" between the feds and your users' accounts is a worthy endeavour. Once they have demanded your SSL keys, encrypted passwords with salts, and in general undone all other security measures that you have put in place to protect the privacy of your users, they will still need one last thing to gain access to your users' accounts: the random one-time-password (OTP) sent to their mobile phones. This means either access to your live database, or intercepting the SMS message sent to your users' mobile phones. While both are possible under the powers the NSA has given itself, and thus this form of 2-Factor Authentication will not provide complete security against an unconstitutional overreach of the federal government, it is at least one more hoop they have to jump through to get their way. ┌∩┐(-_-)┌∩┐


FAQ
-----
### Why Open-Source? Isn't that insecure?
Gringotts was originally conceived as an Authentication-as-a-Service (AaaS) product, much like many of the existing ones out there (like [Swift Identity](https://www.swiftidentity.com/), [Duo Security](https://www.duosecurity.com/), and [Authy](https://www.authy.com/), among others). However, these closed-source "trust-us" models go against the best practices in cryptography and security where the more eyes looking at something, and the more people who try to break it, the more secure it gets. In closed-source, proprietary systems, a vulnurability could be discovered by a malicious actor and exploited (like [the attack against Dropbox](http://www.slashgear.com/dropbox-hack-allows-bypass-of-two-factor-authentication-05289228/)) without any white-hat actor having a chance to point out the issue before-hand.


### OK, but then why not an Open-Source AaaS product?
One word: decentralization. In these days of [PRISM](http://en.wikipedia.org/wiki/PRISM_(surveillance_program), [the NSA forcing companies to hand over encrypted passwords](http://www.npr.org/blogs/thetwo-way/2013/07/26/205709369/report-feds-have-asked-web-firms-for-users-passwords), and general movement towards single-sign-on (SSO) (which I think of more like [single point of failure](http://en.wikipedia.org/wiki/Single_sign-on#Security)) with monolothic companies like Facebook and Google, we are making it easier for malicious actors to gain access to our information by centralizing and consolidating. I think we need to start moving in the opposite direction by creating strong, decentralized systems to store our information. The more spread out and decentralized a user's credentials are, the harder it is for hackers and other malicious agents (read: the government) to abuse a user's information. It's time to take back our privacy. Gringotts is a small step in that direction.


### Why SMS? Why not Google Authenticator? Or a proprietary application?

 1. **Ease and adoption.** Simply put, SMS is easier and more ubiquitious than Google Authenticator. (Nearly) everyone has SMS capability, but not everyone has a smart-phone which can run an app like Google Authenticator; and even fewer have the patience (or tech savvy) to correctly set up their phones. The same goes for a proprietary app. Entering a phone number and confirming an SMS message is a *lot* easier for users, and therefore they are more likely to adopt and benefit from the privacy and security that we are trying to provide.

 1. **Security.** The randomly-generated one-time-password (OTP) sent through SMS is more secure than the private-key time-based one-time-password (TOTP) that Google Authenticator uses. Why? Well, if your database is compromised, your users' passwords and salts are sitting right next to the private TOTP key that was supposed to keep hackers out of your users' accounts. Ooops! With a random password, a database leak does not matter. The code the malicious agent will see is useless. They would need access to your users' mobile phones.
 

### Is Gringotts secure?

I'm doing the best that I can to make the answer to that question a *"yes"*, but I need your help seeing issues and flaws I have missed over overlooked. That said, here are a few known aspects of security, and how Gringotts handles them:

**Random OTP > TOTP:** Most 2-Factor Auth services use time-based one-time-passwords (TOTP) that utilize a shared secret between client and server in order to generate a password that changes every 60 seconds. While this is cool, and most people have jumped on this bandwagon, I personally think that it's not suitable for our purposes. With Gringotts, the idea is that 2FA becomes a part of your system, decentralized, without any 3rd-party. If you store the private TOTP shared secret in your database, next to your user's password and salt, you are opening yourself up to a security breach. By using a Random OTP with a short expiration time, even if a malicious agent sees the last-sent OTP, it will no longer be usable.

**Man in the Middle Attacks:** TODO

**Replay Attacks:** TODO

**Cross-Site Request Forgery:** TODO


Contributing
------

I am actively and eagerly seeking input and contributions from the open-source community regarding:

 * **High Level:** Constructive criticism of this implementation of 2-Factor Authentication (random OTP send through SMS)

 * **Flow:** Suggestions on improving the user-experience (opt-in, confirmation, verification, locked-out, opt-out)
 
 * **Issues:** Test this with your application and let me know how it goes! (Remember: create an experimental branch!)

 * **Improvements:** You know the drill: fork, create topic branch, write test cases, make change, submit pull request.

 * **Encouragement:** Success stories or other *buenas ondas* validating that this project is worthwhile.


Special Thanks To
-----

* [@troyd](https://twitter.com/troyd) for conceptual feedback in the early stages and consistent encouragement to get my ass in gear.

* Abhishek for philosophical discussions about motivation and the lack there-of. "Don't think. Just do it."

* [jlukic](https://github.com/jlukic/) for inspiring me to with his kick.ass. [Semantic-UI](http://semantic-ui.com) project. You're my hero.

* [Nitrous.io](https://www.nitrous.io/join/012YtP048go) for the awesome web-based IDE that allows me to work from internet cafes. (disclaimer: referral link)

* [Supertramp Hostel](http://www.supertramphostel.com/en) and Machu Picchu, Peru for 8 months of good times, food, accomodation, internet, and motivation to get the hell out of here and get on with my life. Thanks, I really needed this. =)


Disclaimer
-----
Gringotts 2-Factor Authentication is not associated with Warner Bros. Entertainment Inc., J.K. Rowling, or any of the "Harry Potter" books or films. HARRY POTTER is a registered trade-mark of Warner Bros. Entertainment Inc.
