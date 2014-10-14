FactoryGirl.define do
  factory :chapter do
    name { Faker::Lorem.word }
    body { Faker::Lorem.paragraph }
    sequence(:chapter_order) 
  end
end
