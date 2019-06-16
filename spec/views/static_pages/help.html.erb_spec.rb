# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'static_pages/help.html.erb', type: :view do
  it 'renders' do
    render

    expect(rendered).to have_selector('h1', text: 'Help')
  end
end
