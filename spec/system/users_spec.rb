# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let(:user) { build_stubbed(:user) }

  describe 'visiting the index' do
    before { create_list(:user, 5) }
    it 'shows a list of users' do
      visit users_url
      expect(page).to have_selector 'h1', text: 'Users'
    end
  end

  describe 'creating a User' do
    it 'shows a success message' do
      visit users_url
      click_on 'Sign up'

      fill_in 'Email', with: user.email
      fill_in 'Name', with: user.name
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'

      click_on 'Sign up'

      expect(page).to have_text 'You have signed up successfully'
      click_on 'Back'
    end
  end

  describe 'updating a User' do
    let(:current_user) { create(:user) }
    before { create_list(:user, 5) }

    it 'shows a success message' do
      sign_in current_user
      visit root_path

      click_on 'Account'
      click_on 'Settings'

      fill_in 'Email', with: user.email
      fill_in 'Name', with: user.name
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      fill_in 'Current password', with: 'password'
      click_on 'Save changes'

      expect(page).to have_text 'Profile has been updated successfully'
    end
  end

  describe 'destroying a User' do
    before { create_list(:user, 5) }

    it 'shows a success message' do
      visit users_url
      page.accept_confirm do
        click_on 'Destroy', match: :first
      end

      expect(page).to have_text 'User was successfully destroyed'
    end
  end
end
