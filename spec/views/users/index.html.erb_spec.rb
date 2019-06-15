# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/index', type: :view do
  fixtures :users
  before(:each) do
    assign(:users, [users(:user), users(:admin)])
  end

  it 'renders a list of users' do
    render

    aggregate_failures do
      assert_select 'tr>th', text: 'Name'.to_s, count: 1
      assert_select 'tr>th', text: 'Email'.to_s, count: 1
    end
  end
end
