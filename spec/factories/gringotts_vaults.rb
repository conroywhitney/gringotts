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
    
  end
end
    