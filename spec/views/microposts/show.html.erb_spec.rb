# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'microposts/show', type: :view do
  fixtures :microposts

  before(:each) do
    @micropost = assign(:micropost, microposts(:one))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Content:/)
    expect(rendered).to match(/User/)
  end
end
