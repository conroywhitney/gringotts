# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :base_gringotts_attempt, :class => 'Gringotts::Attempt' do
    vault_id 1
    
    factory :bad_without_code_attempt do
      code_received nil
    end
    
    factory :good_gringotts_attempt do
      code_received { FactoryGirl.create(:good_gringotts_code).value }
    end
    
    factory :successful_gringotts_attempt do
      code_received { FactoryGirl.create(:good_gringotts_code).value }
      successful true
    end
    
    factory :stale_gringotts_attempt do
      code_received { FactoryGirl.create(:stale_gringotts_code).value }
    end
    
    factory :used_gringotts_attempt do
      code_received { FactoryGirl.create(:successful_gringotts_attempt).code_received }
    end
    
    factory :bad_without_user_attempt do
      vault_id nil
      code_received "12345"
    end
    
  end
end
