# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'microposts/index', type: :view do
  fixtures :microposts
  before(:each) do
    assign(:microposts, [microposts(:one), microposts(:two), microposts(:three)])
  end

  it 'renders a list of microposts' do
    render
    assert_select 'tr>th', text: 'Content'
    assert_select 'tr>th', text: 'User'
  end
end
