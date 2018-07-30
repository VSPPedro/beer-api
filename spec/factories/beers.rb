FactoryBot.define do
  factory :beer do
    name { Faker::Beer.name }
    description { Faker::Lorem.sentence }
    fabrication { Faker::Date.backward(5000) }

    factory :beer_with_creators_and_tips do
      after :create do |beer|
        create_list :creator, 3, beer: beer
        create_list :tip, 3, beer: beer
      end

      factory :beer_with_creators_and_tips_and_volumes do
        after(:create) do |beer|
          beer.volumes = create_list(:volume, 3)
        end
      end
    end
  end
end
