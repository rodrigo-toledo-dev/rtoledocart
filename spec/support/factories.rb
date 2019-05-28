require 'faker'

FactoryBot.define do
  factory :product do
    ref_id { Faker::Number.number(3) }
    name { Faker::Name.name }
    price { Faker::Number.decimal(2) }
    score { Faker::Number.number(3) }
  end
end