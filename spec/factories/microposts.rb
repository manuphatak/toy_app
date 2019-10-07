# frozen_string_literal: true

# == Schema Information
#
# Table name: microposts
#
#  id         :bigint           not null, primary key
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_microposts_on_user_id                 (user_id)
#  index_microposts_on_user_id_and_created_at  (user_id,created_at)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

FactoryBot.define do
  factory :micropost do
    content { Faker::Quote.famous_last_words }
    user
    created_at { Faker::Time.between(from: 1.year.ago, to: Time.zone.today) }
    updated_at { Faker::Time.between(from: created_at, to: Time.zone.today) }
  end
end
