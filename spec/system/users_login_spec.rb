# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'UsersLogin', type: :system do
  describe 'given an invalid login' do
    let(:user) { build_stubbed(:user) }
    it 'does not login' do
      visit login_path

      fill_in 'Email', with: 'fake@example.com'
      fill_in 'Password', with: 'password'
      click_button 'Log in'

      expect(current_path).to eq(login_path)

      expect(page).to have_selector '.alert-danger', text: 'Invalid email/password'

      visit root_path
      expect(page).not_to have_selector '.alert-danger', text: 'Invalid email/password'
    end
  end

  describe 'given valid login information' do
    let!(:user) { create(:user, password: 'password') }

    it 'does login' do
      visit root_path

      click_on 'Log in'

      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'password'
      check 'Remember me'
      click_button 'Log in'

      expect(current_path).to eq(user_path(user))

      aggregate_failures do
        expect(page).not_to have_link 'Log in'

        click_on 'Account'
        expect(page).to have_link 'Log out', href: logout_path
        expect(page).to have_link 'Profile', href: user_path(user)
      end

      aggregate_failures do
        click_on 'Log out'
        expect(current_path).to eq(root_path)
        expect(page).to have_link 'Log in'
      end
    end
  end
end
