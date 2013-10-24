# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :base_gringotts_settings, aliases: [:default], class: Gringotts::Settings do
    vault_id 1
    
    factory :bad_phone_number_missing_settings do
      phone_number nil
    end
    
    factory :bad_phone_number_settings do
      phone_number "12345"
    end
      
    factory :good_us_phone_number_settings do
      phone_number "(444) 444-4444"
    end
      
    factory :good_pe_phone_number_settings do
      phone_number "(084) 791224"
    end
  end
  
end
