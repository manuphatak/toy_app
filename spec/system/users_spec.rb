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
      visit root_path
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

      expect(page).to have_text 'Profile has been updated successfully'
    end
  end

  describe 'cancelling an account' do
    before { login_as create(:user) }

    it 'shows a success message' do
      visit root_path

      click_on 'Account'
      click_on 'Settings'

      page.accept_confirm do
        click_on 'Cancel my account'
      end

      expect(page).to have_text 'Your account has been successfully cancelled.'
    end
  end
end
