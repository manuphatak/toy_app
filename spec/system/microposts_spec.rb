# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Microposts', type: :system do
  let(:current_user) { create(:user) }
  before { sign_in current_user }

  describe 'visiting the index' do
    let!(:microposts) { create_list(:micropost, 5, user: current_user) }

    it 'lists microposts' do
      visit root_url
      aggregate_failures do
        within '.microposts' do
          microposts.each do |micropost|
            expect(page).to have_selector 'h3', text: current_user.name
            expect(page).to have_selector 'p', text: micropost.content
          end
        end
      end
    end
  end

  describe 'creating a Micropost' do
    it 'shows user success message' do
      visit root_path

      fill_in 'Content', with: '[redacted]'
      click_on 'Post'

      aggregate_failures do
        within '.alert' do
          expect(page).to have_text 'Micropost created!'
        end

        within '.microposts' do
          expect(page).to have_text '[redacted]'
          expect(page).to have_text 'Posted less than a minute ago.'
        end
      end
    end
  end

  describe 'destroying a Micropost' do
    before { FactoryBot.create(:micropost, user: current_user) }
    it 'shows user success message' do
      visit root_url
      page.accept_confirm do
        click_on 'delete', match: :first
      end

      expect(page).to have_text 'Micropost was successfully destroyed'
    end
  end
end
