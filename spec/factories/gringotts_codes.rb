# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :base_gringotts_code, :class => 'Gringotts::Code' do
    vault_id 1
    
    factory :good_gringotts_code do
    end
    
  end
end
