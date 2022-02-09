FactoryBot.define do
  factory :item do 
    name { Faker::FunnyName.name }
    description { Faker::Lorem.sentence(word_count: 3) }
    unit_price { Faker::Number.within(range: 1..10) }
  end 
end 