FactoryBot.define do
  factory :volume do
    value { rand(250..5000) }
    unit { Faker:Lorem.word }
  end
end
