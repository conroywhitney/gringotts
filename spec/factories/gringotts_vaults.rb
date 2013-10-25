# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  
  factory :base_gringotts_vault, class: Gringotts::Vault do
    
    factory :good_gringotts_vault do
      user_id FactoryGirl.create(:user).id
      
      # So we can re-use this factory across multiple associations
      # without receiving a duplicate validation error
      # Thanks to: http://stackoverflow.com/questions/7145256/find-or-create-record-through-factory-girl-association
      initialize_with { Gringotts::Vault.where(user_id: user_id).first_or_create }
    end
    
    factory :bad_missing_user_gringotts_vault do
      user_id nil
    end
    
  end
end
    