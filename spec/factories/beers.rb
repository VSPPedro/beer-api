FactoryBot.define do
  factory :beer do
    name { Faker::Beer.name }
    description { Faker::Lorem.sentence }
    fabrication { Faker::Date.backward(5000) }

    factory :beer_with_creators do
      transient do
        creators_count 3
      end

      after(:attributes_for) do |beer, evaluator|
        create_list(:creator, evaluator.creators_count, beer: beer)
      end
    end
  end
end
