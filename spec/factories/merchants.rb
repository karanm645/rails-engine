# require 'factory_bot'
FactoryBot.define do
  factory :merchant do 
    name { Faker::FunnyName.name }
  end 
end 