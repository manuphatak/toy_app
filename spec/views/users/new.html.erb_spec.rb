# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/new', type: :view do
  let!(:user) { assign(:user, FactoryBot.build(:user)) }

  it 'renders new user form' do
    render

    aggregate_failures do
      expect(rendered).to have_selector format('form[action=%p][method=%p]', users_path, 'post')
      expect(rendered).to have_selector format('input[name=%p]', 'user[name]')
      expect(rendered).to have_selector format('input[name=%p]', 'user[email]')
      expect(rendered).to have_selector format('input[name=%p]', 'user[password]')
      expect(rendered).to have_selector format('input[name=%p]', 'user[password_confirmation]')
    end
  end
end
