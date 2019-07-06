# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'SiteLayout', type: :system do
  it 'has links from layout' do
    visit root_path
    expect(page).to have_link  href: root_path, count: 2
    expect(page).to have_link  href: help_path
    expect(page).to have_link  href: about_path
    expect(page).to have_link  href: contact_path
    expect(page).to have_link  href: new_user_registration_path
  end
end
