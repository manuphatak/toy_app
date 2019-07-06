# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/index', type: :view do
  let!(:users) { assign(:users, FactoryBot.create_list(:user, 5)) }

  it 'renders a list of users' do
    aggregate_failures do
      render

      users.each do |user|
        expect(rendered).to have_selector('ul>li h2', text: user.name, count: 1)
      end
    end
  end
end
