# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/edit', type: :view do
  let!(:user) { assign(:user, FactoryBot.build_stubbed(:user)) }

  it 'renders the edit user form' do
    render

    aggregate_failures do
      expect(rendered).to have_selector format('form[action=%p][method=%p]', user_path(user), 'post')
      expect(rendered).to have_selector format('input[name=%p]', 'user[name]')
      expect(rendered).to have_selector format('input[name=%p]', 'user[email]')
      expect(rendered).to have_selector format('input[name=%p]', 'user[password]')
      expect(rendered).to have_selector format('input[name=%p]', 'user[password_confirmation]')
    end
  end
end
