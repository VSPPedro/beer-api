FactoryBot.define do
  factory :creator do
    name { Faker::Name.name }
    beer
  end
end
