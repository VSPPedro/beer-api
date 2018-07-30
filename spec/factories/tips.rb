FactoryBot.define do
  factory :tip do
    description { Faker::Lorem.sentence }
    beer
  end
end
