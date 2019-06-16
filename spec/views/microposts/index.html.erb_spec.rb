# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'microposts/index', type: :view do
  before { assign(:microposts, FactoryBot.create_list(:micropost, 5)) }

  it 'renders a list of microposts' do
    render

    expect(rendered).to have_selector('tr>td', text: 'Show', count: 5)
  end
end
