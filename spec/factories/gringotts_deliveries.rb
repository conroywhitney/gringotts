# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  
  factory :base_gringotts_delivery, :class => 'Gringotts::Delivery' do
    vault_id { FactoryGirl.create(:good_gringotts_vault_with_phone_number).id }
    
    factory :good_gringotts_delivery do   
      strategy_class "Gringotts::DeliveryStrategies::TestStubStrategy"
    end
    
    factory :error_raising_gringotts_delivery do
      strategy_class "Gringotts::DeliveryStrategies::ErrorRaisingStrategy"
    end
    
    factory :bad_invalid_strategy_gringotts_delivery do
      strategy_class "Gringotts::DeliveryStrategies::DoesNotExistStrategy"
    end
    
  end
  
end
