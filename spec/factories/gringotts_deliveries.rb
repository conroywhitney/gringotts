# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :base_gringotts_delivery, :class => 'Gringotts::Delivery' do
    vault_id { FactoryGirl.create(:good_gringotts_vault_with_settings).id }
    
  end
end
