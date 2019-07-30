# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/index', type: :view do
  before { create_list(:user, 40) }
  before { assign(:users, User.page(1)) }
  before { sign_in create(:user) }

  it 'renders a paginated list of users' do
    aggregate_failures do
      render

      expect(rendered).to have_selector('ul#users') do
        User.page(1).each do |user|
          expect(rendered).to have_selector('ul>li p', text: user.email, count: 1)
          expect(rendered).to have_link(user.name, href: user_path(user))
        end

        User.page(2).each do |user|
          expect(rendered).to have_no_link(user.name, href: user_path(user))
        end
      end
    end
  end
end
