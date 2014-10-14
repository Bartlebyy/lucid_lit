FactoryGirl.define do
  factory :project do
    offset { Faker::Number.number(2) }
    length { Faker::Number.digit }
    original_word { Faker::Lorem.word }
    note { Faker::Lorem.paragraph }
  end
end
