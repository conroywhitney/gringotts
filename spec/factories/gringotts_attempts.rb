# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :base_gringotts_attempt, :class => 'Gringotts::Attempt' do
    vault_id 1
    
    factory :bad_without_user_attempt do
      vault_id nil
      code_received "12345"
    end
    
    factory :bad_without_code_attempt do
      code_received nil
    end
    
  end
end
