# frozen_string_literal: true

FactoryBot.define do
  factory :micropost do
    content { Faker::Quote.famous_last_words }
    user
  end
end
