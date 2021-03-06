# frozen_string_literal: true
FactoryGirl.define do
  factory :post do
    title { Faker::Name.title }
    body { Faker::Lorem.paragraph }
    user
  end
end
