# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Relationships', type: :system do
  before { sign_in current_user }

  describe 'following page' do
    let(:current_user) { create(:user, :with_following) }

    it 'shows following' do
      visit following_user_path(current_user)

      aggregate_failures do
        expect(current_user.following).not_to be_empty
        within 'h2>small' do
          expect(page).to have_text current_user.following.count
        end
        within 'ol.users' do
          current_user.following.each do |followed|
            expect(page).to have_link followed.name, href: user_path(followed)
          end
        end
      end
    end
  end

  describe 'followers page' do
    let(:current_user) { create(:user, :with_followers) }

    it 'shows followers' do
      visit followers_user_path(current_user)

      aggregate_failures do
        expect(current_user.followers).not_to be_empty
        within 'h2>small' do
          expect(page).to have_text current_user.followers.count
        end
        within 'ol.users' do
          current_user.followers.each do |follower|
            expect(page).to have_link follower.name, href: user_path(follower)
          end
        end
      end
    end
  end
end
