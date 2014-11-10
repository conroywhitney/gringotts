# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :base_gringotts_settings, aliases: [:default], class: Gringotts::Settings do
    vault_id { FactoryGirl.create(:good_gringotts_vault).id }
    
    factory :bad_phone_number_missing_settings do
      phone_number nil
    end
    
    factory :bad_phone_number_settings do
      phone_number "12345"
    end
      
    factory :good_us_phone_number_settings do
      phone_number '+1 (444) 444-4444'
    
      factory :confirmed_settings do
        vault_id { FactoryGirl.create(:confirmed_gringotts_vault).id }
      end
    end
      
    factory :good_pe_phone_number_settings do
      phone_number "+41 44 111 22 33"
    end
    
  end
  
end
