# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Microposts', type: :system do
  let(:micropost) { FactoryBot.build(:micropost) }
  let(:user) { FactoryBot.create(:user) }

  describe 'visiting the index' do
    before { FactoryBot.create_list(:micropost, 10) }
    it 'lists microposts' do
      visit microposts_url
      expect(page).to have_selector 'h1', text: 'Microposts'
    end
  end

  describe 'creating a Micropost' do
    it 'shows user success message' do
      visit microposts_url
      click_on 'New Micropost'

      fill_in 'Content', with: micropost.content
      fill_in 'User', with: user.id
      click_on 'Create Micropost'

      expect(page).to have_text 'Micropost was successfully created'
      click_on 'Back'
    end
  end

  describe 'updating a Micropost' do
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

  describe 'destroying a Micropost' do
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
