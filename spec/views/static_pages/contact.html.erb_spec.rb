# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'static_pages/contact.html.erb', type: :view do
  it 'renders' do
    render

    expect(rendered).to have_selector('h1', text: 'Contact')
  end
end
