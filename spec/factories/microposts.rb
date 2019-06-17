# frozen_string_literal: true

# == Schema Information
#
# Table name: microposts
#
#  id         :integer          not null, primary key
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
# Indexes
#
#  index_microposts_on_user_id  (user_id)
#

FactoryBot.define do
  factory :micropost do
    content { Faker::Quote.famous_last_words }
    user
    created_at { Faker::Time.between(1.year.ago, Time.zone.today, :all) }
    updated_at { Faker::Time.between(created_at, Time.zone.today, :all) }
  end
end
