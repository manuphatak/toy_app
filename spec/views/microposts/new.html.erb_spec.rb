# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'microposts/new', type: :view do
  fixtures :users
  before(:each) do
    assign(:micropost, Micropost.new(content: 'MyText', user: users(:user)))
  end

  it 'renders new micropost form' do
    render

    assert_select 'form[action=?][method=?]', microposts_path, 'post' do
      assert_select 'textarea[name=?]', 'micropost[content]'

      assert_select 'input[name=?]', 'micropost[user_id]'
    end
  end
end
