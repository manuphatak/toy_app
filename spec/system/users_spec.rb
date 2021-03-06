# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let(:user) { build_stubbed(:user) }

  describe 'visiting the index' do
    before { create_list(:user, 5) }
    before { login_as create(:user) }

    it 'shows a list of users' do
      visit users_path
      expect(page).to have_selector 'h1', text: 'Users'
    end
  end

  describe 'creating a User' do
    it 'shows a success message' do
      # Sign up
      visit root_path
      click_on 'Sign up'

      fill_in 'Email', with: user.email
      fill_in 'Name', with: user.name
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'

      click_on 'Sign up'
      expect(page).to have_text 'You have signed up successfully'

      # Email confirmatation
      current_user = User.find_by(email: user.email)
      visit user_confirmation_path(confirmation_token: current_user.confirmation_token)

      expect(page).to have_text 'Your email address has been successfully confirmed.'

      # Log in
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'password'
      click_on 'Log in'

      # Default log in page
      expect(current_path).to eq user_path(current_user)
      expect(page).to have_text user.name

      # Navigate to users page
      click_on 'Back'
      expect(current_path).to eq users_path
    end
  end

  describe 'showing user details' do
    let(:posts_count) { 40 }
    let(:user) { create(:user, :with_posts, posts_count: posts_count) }
    before { login_as user }

    it 'shows user details and paginated microposts' do
      visit user_path(user)

      expect(page).to have_title(user.name)

      within 'h1' do
        expect(page).to have_text(user.name)
      end

      within 'h2' do
        expect(page).to have_text("Microposts (#{posts_count})")
      end

      within '.microposts' do
        user.microposts.page(1).each do |micropost|
          within "#micropost-#{micropost.id}" do
            expect(page).to have_text(micropost.content)
          end
        end
      end

      within '.pagination' do
        click_link '2'
      end

      within '.microposts' do
        user.microposts.page(2).each do |micropost|
          within "#micropost-#{micropost.id}" do
            expect(page).to have_text(micropost.content)
          end
        end
      end
    end
  end

  describe 'updating a User' do
    before { login_as create(:user) }
    before { create_list(:user, 5) }

    it 'shows a success message' do
      visit root_path

      click_on 'Account'
      click_on 'Settings'

      fill_in 'Email', with: user.email
      fill_in 'Name', with: user.name
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      fill_in 'Current password', with: 'password'
      click_on 'Save changes'

      expect(page).to have_text 'Your profile has been updated successfully'
    end
  end
end
