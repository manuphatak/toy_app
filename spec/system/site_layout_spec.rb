# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'SiteLayout', type: :system do
  context 'when not logged in' do
    it 'has links from layout' do
      visit root_path
      expect(page).to have_link  href: root_path, count: 2
      expect(page).to have_link  href: help_path
      expect(page).to have_link  href: about_path
      expect(page).to have_link  href: contact_path
      expect(page).to have_link  href: new_user_registration_path
      expect(page).to have_link  href: new_user_session_path
      expect(page).not_to have_link href: users_path
    end
  end

  context 'when logged in' do
    let!(:current_user) { create(:user) }
    before { login_as current_user }
    it 'has links from layout' do
      visit root_path

      expect(page).not_to have_link href: new_user_session_path
      expect(page).to have_link href: users_path

      click_on 'Account'
      expect(page).to have_link  href: user_path(current_user)
      expect(page).to have_link  href: edit_user_registration_path
      expect(page).to have_link  href: destroy_user_session_path
    end
  end
end
