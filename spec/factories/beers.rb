FactoryBot.define do
  factory :beer do
    name { Faker::Beer.name }
    description { Faker::Lorem.sentence }
    fabrication { Faker::Date.backward(5000) }
  end
end
