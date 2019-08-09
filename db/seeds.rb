# frozen_string_literal: true

unless Rails.env.test?
  FactoryBot.create_list(:user, 50, :with_posts)

  unless User.exists?(email: 'user@example.com')
    FactoryBot.create(:user, :with_posts, name: 'Joe Sixpack', email: 'user@example.com', posts_count: 30)
  end

  unless User.exists?(email: 'admin@example.com')
    FactoryBot.create(:admin, :with_posts, name: 'Jane Juggs', email: 'admin@example.com', posts_count: 50)
  end

  User.all.pluck(:id).each do |user_id|
    cannot_follow = Relationship.select(:followed_id).where(follower_id: user_id).pluck(:followed_id).uniq + [user_id]
    follow_count = rand(0...User.count)
    followed_ids = User.select(:id).where.not(id: cannot_follow).order('RANDOM()').limit(follow_count).pluck(:id).uniq

    relationships = followed_ids.map do |followed_id|
      { follower_id: user_id, followed_id: followed_id, created_at: Faker::Time.backward(30) }
    end

    Relationship.create(relationships)
  end
end
