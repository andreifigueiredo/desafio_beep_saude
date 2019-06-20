FactoryBot.define do
  factory :currency do
    value { Faker::Number.positive }
    quote { Faker::Number.between(0, 2) }
    date { Time.now }
  end
end
