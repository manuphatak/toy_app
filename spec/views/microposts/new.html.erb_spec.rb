# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'microposts/new', type: :view do
  let!(:micropost) { assign(:micropost, FactoryBot.build(:micropost)) }

  it 'renders new micropost form' do
    render

    assert_select 'form[action=?][method=?]', microposts_path, 'post' do
      assert_select 'textarea[name=?]', 'micropost[content]'

      assert_select 'input[name=?]', 'micropost[user_id]'
    end
  end
end
