# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string
#  name            :string
#  password_digest :string
#  remember_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email(name) }
    password { 'password' }
    password_confirmation { password }

    trait :with_posts do
      transient do
        posts_count { 10 }
      end

      after(:create) do |user, evaluator|
        create_list(:micropost, evaluator.posts_count, user: user)
      end
    end
  end
end
