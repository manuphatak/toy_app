# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

FactoryBot.create_list(:user, 25, :with_posts)

unless User.exists?(email: 'user@example.com')
  FactoryBot.create(:user, :with_posts, name: 'Joe Sixpack', email: 'user@example.com', posts_count: 20)
end

unless User.exists?(email: 'admin@example.com')
  FactoryBot.create(:admin, :with_posts, name: 'Jane Juggs', email: 'admin@example.com', posts_count: 50)
end
