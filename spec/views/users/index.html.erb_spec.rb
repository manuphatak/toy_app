# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/index', type: :view do
  before { assign(:users, FactoryBot.create_list(:user, 5)) }

  it 'renders a list of users' do
    aggregate_failures do
      render

      expect(rendered).to have_selector('tr>td', text: 'Show', count: 5)
    end
  end
end
