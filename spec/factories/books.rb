FactoryGirl.define do
  factory :book do
    title { Faker::Company.catch_phrase }
    author { Faker::Name.name }
  end
end
