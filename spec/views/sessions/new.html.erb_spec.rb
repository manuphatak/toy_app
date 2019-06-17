# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'sessions/new.html.erb', type: :view do
  it 'renders a login form' do
    render

    aggregate_failures do
      expect(rendered).to have_selector 'h1', text: 'Log in'
      expect(rendered).to have_selector format('form[action=%p][method=%p]', login_path, 'post')
      expect(rendered).to have_field 'session[email]', type: 'email'
      expect(rendered).to have_field 'session[password]', type: 'password'
      expect(rendered).to have_button 'Log in'
    end
  end
end
