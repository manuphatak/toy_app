# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'microposts/index', type: :view do
  let!(:microposts) { assign(:microposts, FactoryBot.create_list(:micropost, 5)) }

  it 'renders a list of microposts' do
    render
    assert_select 'tr>th', text: 'Content'
    assert_select 'tr>th', text: 'User'
  end
end
