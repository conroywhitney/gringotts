# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :gringotts_attempt, :class => 'Gringotts::Attempt' do
    user_id 1
  end
end
