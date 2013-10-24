# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  
  factory :base_gringotts_vault, class: Gringotts::Vault do
    
    factory :good_gringotts_vault do
      user_id FactoryGirl.create(:user).id
    end
    
    factory :bad_missing_user_gringotts_vault do
      user_id nil
    end
    
  end
end
    