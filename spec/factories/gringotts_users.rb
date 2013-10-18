# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :gringotts_user, aliases: [:default], class: Gringotts::User do
    user_id FactoryGirl.create(:user, email: "example@gringotts2fa.org").email
    
    factory :opted_in_user do
      active true
    end
  end
  
end
