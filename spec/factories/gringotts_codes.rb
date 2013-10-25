# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :base_gringotts_code, :class => 'Gringotts::Code' do
    vault_id 1
    
    factory :good_gringotts_code do
      expires_at { Time.now + 30.days }
    end
    
    factory :different_gringotts_code do
      expires_at { Time.now + 30.days }
    end
    
    factory :stale_gringotts_code do
      expires_at { Time.now - Gringotts::AttemptValidator::CODE_FRESHNESS_LIMIT }
    end
    
  end
end
