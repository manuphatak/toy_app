# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'UsersLogin', type: :system do
  let(:user) { build_stubbed(:user) }

  describe 'given an invalid login' do
    it '' do
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
end
