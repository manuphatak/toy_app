# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Microposts', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:current_user) { FactoryBot.create(:admin) }
  before { sign_in current_user }

  describe 'visiting the index' do
    before { FactoryBot.create_list(:micropost, 5) }
    it 'lists microposts' do
      visit microposts_url
      expect(page).to have_selector 'h1', text: 'Microposts'
    end
  end

  describe 'creating a Micropost' do
    it 'shows user success message' do
      # visit microposts_url
      # click_on 'New Micropost'
      visit new_micropost_path

      fill_in 'Content', with: '[redacted]'
      fill_in 'User', with: user.id
      click_on 'Create Micropost'

      expect(page).to have_text 'Micropost was successfully created'
      click_on 'Back'
    end
  end

  xdescribe 'updating a Micropost' do
    before { FactoryBot.create(:micropost) }
    it 'shows user success message' do
      visit microposts_url
      click_on 'Edit', match: :first

      fill_in 'Content', with: '[redacted]'
      fill_in 'User', with: user.id
      click_on 'Update Micropost'

      expect(page).to have_text 'Micropost was successfully updated'
      click_on 'Back'
    end
  end

  xdescribe 'destroying a Micropost' do
    before { FactoryBot.create(:micropost) }
    it 'shows user success message' do
      visit microposts_url
      page.accept_confirm do
        click_on 'Destroy', match: :first
      end

      expect(page).to have_text 'Micropost was successfully destroyed'
    end
  end
end
