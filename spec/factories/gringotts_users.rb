# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :gringotts_user, aliases: [:default], class: Gringotts::User do
    user_id FactoryGirl.create(:user, email: "example@gringotts2fa.org").email
    active true
    phone_number "(406) 555-1212"

    factory :bad_phone_number_missing_user do
      phone_number nil
    end
    
    factory :bad_phone_number_user do
      phone_number "12345"
    end
      
    factory :good_us_phone_number_user do
      phone_number "(406) 555-1212"
    end
      
    factory :good_pe_phone_number_user do
      phone_number "(084) 791224"
    end
  end
  
end
