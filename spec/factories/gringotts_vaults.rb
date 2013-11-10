# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  
  factory :base_gringotts_vault, class: Gringotts::Vault do
    owner FactoryGirl.create(:user)
      
    # So we can re-use this factory across multiple associations
    # without receiving a duplicate validation error
    # Thanks to: http://stackoverflow.com/questions/7145256/find-or-create-record-through-factory-girl-association
    initialize_with { Gringotts::Vault.for_owner(owner) }
    
    factory :good_gringotts_vault do
      locked_at nil
      
      factory :good_gringotts_vault_with_phone_number do
        # thanks to: http://stackoverflow.com/questions/18292965/factorygirl-association-parent-cant-be-blank
        after(:create) do |vault|
          FactoryGirl.create(:good_us_phone_number_settings, vault: vault)
        end
      end
    end
    
    factory :bad_missing_owner_gringotts_vault do
      owner_id nil
      owner_type nil
    end
    
    factory :locked_gringotts_vault do
      locked_at { Time.now }
    end
    
    factory :unlockable_gringotts_vault do
      locked_at { Time.now - Gringotts::AttemptValidator::LOCKOUT_PERIOD }
    end
    
    factory :confirmed_gringotts_vault do
      confirmed_at { Time.now }
    end
    
  end
end
    